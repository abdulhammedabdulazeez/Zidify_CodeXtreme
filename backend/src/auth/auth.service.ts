import {
  ForbiddenException,
  Injectable,
  Logger,
  UnauthorizedException,
} from '@nestjs/common';
import { UsersService } from 'src/users/users.service';
import { CreateUserDto } from 'src/users/dtos/create-user.dto';
import { AUTH_MESSAGES } from 'src/shared/constants';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { User } from '@prisma/client';
import { JwtPayload, JwtType, JwtUser, Tokens } from 'src/common/types';
import { LoginAuthDto } from './dtos';
import * as argon from 'argon2';
import * as crypto from 'crypto';
import { UpdateUserDto } from 'src/users/dtos/update-user.dto';
import { DatabaseService } from 'src/database/database.service';
import { CreateSaveBoxDto } from 'src/domains/save-box/dto/create-save-box.dto';
import { SaveBoxService } from 'src/domains/save-box/save-box.service';

@Injectable()
export class AuthService {
  private readonly logger: Logger = new Logger(AuthService.name);
  constructor(
    private usersService: UsersService,
    private readonly configService: ConfigService,
    private readonly jwtService: JwtService,
    private readonly db: DatabaseService,
    private readonly saveBoxService: SaveBoxService,
  ) {}

  /**
   * Creates a new user account with the provided information.
   * The email is a required field on sign up, hence, this function queries the database with the email.
   *
   * @param {CreateUserDto} dto - The user data to use for creating the new user.
   * @returns A promise that resolves to the newly created user.
   */
  async create(dto: CreateUserDto): Promise<Tokens> {
    const userExists =
      (await this.usersService.findByEmail(dto.email)) ||
      (await this.usersService.findByPhoneNumber(dto.phoneNumber));

    if (userExists) {
      throw new ForbiddenException(AUTH_MESSAGES.USER_ALREADY_EXISTS);
    }
    dto.password = await argon.hash(dto.password);
    const user: User = await this.usersService.create(dto);

    // CREATE OTHER USER TABLES
    this.createOtherUserTables(user);

    return await this._returnUserTokens(user);
  }

  /**
   * CREATES OTHER USER TABLES AFTER A USER IS SUCCESSFULLY CREATED ON THE DATABASE.
   * THESE TABLES INCLUDE: SAVE BOX, USER TOTAL SAVINGS, AND SIGNUP ACTIVITY
   *
   * @param {string} userId - The user id of the user to create the tables for.
   * @returns - A promise that resolves to void.
   */
  async createOtherUserTables(user: User): Promise<void> {
    // CREATE A SAVE BOX FOR THE USER
    this.createUserSaveBox(user);

    // CREATE USER TOTAL SAVINGS
    this.createUserTotalSavings(user.id);
  }

  async createUserSaveBox(user: User) {
    const saveBoxDto: CreateSaveBoxDto = {
      userId: user.id,
      accountNumber: this.saveBoxService.generateUnique13DigitNumber(),
      //TODO: ADD ACCOUNT NAME
      // accountName: user.profile.firstName + ' ' + user.profile.lastName,
    };
    return await this.saveBoxService.create(saveBoxDto);
  }

  async createUserTotalSavings(userId: string) {
    await this.db.userSavingsTotal.create({ data: { userId } });
    return;
  }

  /**
   * Returns user tokens after successful authentication.
   * This function also hashes the refresh token before saving it in the database.
   *
   * @param user - The user to generate tokens for.
   * @returns {Promise<Tokens>} A promise that resolves to the user's tokens.
   */
  private async _returnUserTokens(user: User): Promise<Tokens> {
    const tokens = await this._generateTokensForUser(user);

    const updateUserDto = new UpdateUserDto();
    await this.usersService.update(user.id, updateUserDto);

    return tokens;
  }

  /**
   * Logs in a user with the provided email/phoneNumber and password.
   *
   * @param {LoginAuthDto} dto - The user data to use for logging in.
   * @returns A promise that resolves to the user's tokens.
   */
  async login(dto: LoginAuthDto): Promise<Tokens> {
    const user = dto.email
      ? await this.usersService.findByEmail(dto.email)
      : await this.usersService.findByPhoneNumber(dto.phoneNumber);
    if (!user) {
      throw new ForbiddenException(AUTH_MESSAGES.USER_NOT_FOUND);
    }
    const isValidPassword = await this.validatePassword(
      dto.password,
      user.password,
    );
    if (!isValidPassword) {
      const ERROR_MESSAGE = dto.email
        ? AUTH_MESSAGES.INVALID_EMAIL_CREDENTIALS
        : AUTH_MESSAGES.INVALID_PHONE_CREDENTIALS;
      throw new ForbiddenException(ERROR_MESSAGE);
    }
    return await this._returnUserTokens(user);
  }

  /**
   * Refreshes the access token using a given refresh token. It first decodes and verifies the refresh token,
   * then checks if the user still exists and if the token is valid. If all checks pass, it generates and returns
   * a new set of access and refresh tokens for the user.
   *
   * @param refreshToken - The refresh token provided by the user to obtain a new access token.
   * @returns A promise that resolves to an object containing the new access token, refresh token, and user information.
   * @throws {UnauthorizedException} - Throws when the refresh token is invalid, expired, or does not match the user.
   */
  public async refreshToken(refreshToken: string) {
    const decodedRefreshToken = await this._verifyRefreshToken(refreshToken);

    const user = await this.usersService.findOne({
      id: decodedRefreshToken.id,
    });

    if (!user) {
      throw new UnauthorizedException(AUTH_MESSAGES.INVALID_TOKEN);
    }

    if (!(await argon.verify(user.refreshToken, refreshToken))) {
      throw new UnauthorizedException(AUTH_MESSAGES.INVALID_TOKEN);
    }

    const tokenIssuedAt = decodedRefreshToken.iat;
    await this.validateUserFromJWT(user.id, new Date(tokenIssuedAt));

    const tokens = await this._returnUserTokens(user);

    return tokens;
  }

  /**
   * Verifies a user's email based on a given token. This method checks if the token is valid,
   * not expired, and corresponds to an actual user awaiting email verification.
   *
   * @param token The verification token sent to the user's email.
   * @returns An object with a message indicating that the email has been verified.
   * @throws {UnauthorizedException} If the token is invalid or expired, or if no user is found for the provided token.
   */
  public async verifyEmail(token: string) {
    const email = await this._decrypt(
      token,
      this.configService.getOrThrow<string>('EMAIL_VERIFICATION_SALT'),
    );
    const user = await this.usersService.findByEmail(email);

    if (!user) {
      throw new UnauthorizedException(AUTH_MESSAGES.INVALID_TOKEN);
    }

    if (!(await argon.verify(user.emailVerificationToken, token))) {
      throw new UnauthorizedException(AUTH_MESSAGES.INVALID_TOKEN);
    }

    const updateUserDto = new UpdateUserDto();
    updateUserDto.verified = true;
    updateUserDto.emailVerificationToken = null;
    updateUserDto.emailVerificationTokenExpiry = null;

    await this.usersService.update(user.id, updateUserDto);

    return { message: AUTH_MESSAGES.EMAIL_VERIFIED };
  }

  /**
   * Validate user from JWT
   * @param {string} userId - The user id from the JWT
   * @returns
   */
  public async validateUserFromJWT(
    userId: string,
    tokenIssuedAt: Date,
  ): Promise<JwtUser> {
    const user = await this.usersService.findOne({ id: userId });
    if (!user) {
      throw new UnauthorizedException(AUTH_MESSAGES.INVALID_TOKEN);
    }

    return {
      id: user.id,
      email: user.email,
      phoneNumber: user.phoneNumber,
    };
  }

  /**
   * Validates user-inputted password hashed password.
   *
   * @param {string} password - The user-inputted password.
   * @param {string} hashedPassword - The hashed password to compare against.
   * @returns {Promise<boolean>} A promise that resolves to a boolean indicating whether the passwords match.
   */
  public async validatePassword(password: string, hashedPassword: string) {
    return argon.verify(hashedPassword, password);
  }

  /**
   * Generates a new access token for a user.
   *
   * @param {JwtPayload} payload
   * @returns
   */
  private async _generateAccessToken(payload: JwtPayload): Promise<string> {
    // override the type to access token
    payload.type = JwtType.ACCESS;
    try {
      const accessToken = await this.jwtService.signAsync(payload, {
        secret: this.configService.get<string>('JWT_SECRET'),
        expiresIn: this.configService.get<string>(
          'JWT_ACCESS_TOKEN_EXPIRATION_TIME',
        ),
      });

      return accessToken;
    } catch (error) {
      this.logger.error('Error generating access token:', error);
      throw new Error(error);
    }
  }

  /**
   * Generates a new refresh token for a user.
   *
   * @param {JwtPayload} payload
   * @returns
   */
  private async _generateRefreshToken(payload: JwtPayload): Promise<string> {
    // override the type to refresh token
    payload.type = JwtType.REFRESH;
    const refreshToken = await this.jwtService.signAsync(payload, {
      secret: this.configService.get<string>('JWT_SECRET'),
      expiresIn: this.configService.get<string>(
        'JWT_REFRESH_TOKEN_EXPIRATION_TIME',
      ),
    });

    return refreshToken;
  }

  private async _verifyRefreshToken(token: string): Promise<JwtPayload> {
    return await this.jwtService.verifyAsync(token, {
      secret: this.configService.get<string>('JWT_SECRET'),
    });
  }

  /**
   * Generates access and refresh tokens for a given user. This function constructs a payload from the user's
   * information and then uses specific methods to generate JWT access and refresh tokens.
   *
   * @param user - The user object containing at least email, id, handle, and userType.
   * @returns A promise that resolves to an object containing both the accessToken and refreshToken.
   */
  private async _generateTokensForUser(user: User): Promise<Tokens> {
    const payload: JwtPayload = {
      id: user.id,
      email: user.email,
      phoneNumber: user.phoneNumber,
      aud: this.configService.get<string>('JWT_AUDIENCE'),
      iss: this.configService.get<string>('JWT_ISSUER'),
      iat: Date.now(), //Math.floor(Date.now() / 1000),
    };
    const accessToken = await this._generateAccessToken(payload);
    const refreshToken = await this._generateRefreshToken(payload);

    return { accessToken, refreshToken };
  }

  /**
   * Generates a 6-digit OTP.
   *
   * @returns {number} - A 6-digit OTP.
   */
  private _generateOtp() {
    return Math.floor(100000 + Math.random() * 900000);
  }

  /**
   * Encrypts a message using AES-256-CTR algorithm with a randomly generated IV.
   *
   * @param message - The message to be encrypted.
   * @param salt - The salt key for deriving the encryption key.
   * @returns A Promise resolving to the encrypted message.
   * @throws {Error} If an error occurs during the encryption process.
   */
  private async _encrypt(message: string, salt: string): Promise<string> {
    return new Promise<string>((resolve, reject) => {
      try {
        const key = crypto.createHash('sha256').update(salt).digest();
        const iv = crypto.randomBytes(16);
        const cipher = crypto.createCipheriv('aes-256-ctr', key, iv);

        let encryptedMessage = cipher.update(message, 'utf-8', 'hex');
        encryptedMessage += cipher.final('hex');

        resolve(iv.toString('hex') + encryptedMessage);
      } catch (error) {
        reject(error);
      }
    });
  }

  /**
   * Decrypts an encrypted message using AES-256-CTR algorithm.
   *
   * @param encryptedMessage - The encrypted message.
   * @param salt - The salt key for deriving the decryption key.
   * @returns A Promise resolving to the decrypted message.
   * @throws {Error} If an error occurs during the decryption process.
   */
  private async _decrypt(
    encryptedMessage: string,
    salt: string,
  ): Promise<string> {
    return new Promise<string>((resolve, reject) => {
      try {
        const key = crypto.createHash('sha256').update(salt).digest();
        const iv = Buffer.from(encryptedMessage.slice(0, 32), 'hex');
        const encryptedText = encryptedMessage.slice(32);

        const decipher = crypto.createDecipheriv('aes-256-ctr', key, iv);

        let decryptedMessage = decipher.update(encryptedText, 'hex', 'utf-8');
        decryptedMessage += decipher.final('utf-8');

        resolve(decryptedMessage);
      } catch (error) {
        reject(error);
      }
    });
  }

  findAll() {
    return `This action returns all auth`;
  }

  findOne(id: number) {
    return `This action returns a #${id} auth`;
  }
}
