import { ForbiddenException, Injectable } from '@nestjs/common';
import { CreateUserDto } from './dtos/create-user.dto';
import { UpdateUserDto } from './dtos/update-user.dto';
import { DatabaseService } from 'src/database/database.service';
import { User } from '@prisma/client';
import { GoogleAuthDto } from 'src/auth/dtos';
import { ConfigService } from '@nestjs/config';
import { SaveBoxService } from 'src/domains/save-box/save-box.service';

@Injectable()
export class UsersService {
  constructor(
    private readonly db: DatabaseService,
    private readonly configService: ConfigService,
    private readonly saveBoxService: SaveBoxService,
  ) {}

  /**
   * Creates a new user with profile
   * @param {CreateUserDto | GoogleAuthDto} dto - user data
   * @returns {Promise<User>} - the newly created user with profile
   */
  public async create(dto: CreateUserDto | GoogleAuthDto): Promise<User> {
    const firstName = dto.firstName;
    const lastName = dto.lastName;
    delete dto.firstName;
    delete dto.lastName;
    const user = await this.db.user.create({
      data: {
        ...dto,
        profile: {
          create: {
            firstName,
            lastName,
            email: dto.email,
            phoneNumber: 'phoneNumber' in dto ? dto.phoneNumber : null,
          },
        },
      },
      include: {
        profile: true,
      },
    });

    return user;
  }

  /**
   * Finds a user by email
   *
   * @param {string} email - the user email to query against the database
   * @returns {Promise<User>} - the user with the email
   */
  public async findByEmail(email: string): Promise<User> {
    const user = await this.db.user.findUnique({
      where: { email },
    });
    return user;
  }

  /**
   * Finds a user by phone number
   *
   * @param {string} phoneNumber - the user phone number to query against the database
   * @returns {Promise<User>} - the user with the phone number
   */
  public async findByPhoneNumber(phoneNumber: string): Promise<User> {
    const user = await this.db.user.findUnique({
      where: { phoneNumber },
    });
    return user;
  }

  /**
   * Finds the current user
   *
   * @param {User} user - the current user
   * @returns {Promise<User>} - the current user
   */
  public async findMe(id: string): Promise<User> {
    const user = await this.db.user.findUnique({
      where: { id },
      include: {
        profile: true,
        userSavingsTotal: true,
        activities: true,
        saveBox: true,
      },
    });
    return user;
  }

  /**
   * Fetches user's SaveBox
   * @param userId - The user ID
   * @returns {SaveBox} - The SaveBox of the authenticated user
   */
  async getSavebox(userId: string) {
    return await this.saveBoxService.findUserSaveBox(userId);
  }

  findAll() {
    return `This action returns all users`;
  }

  /**
   * Finds the user with the given query.
   *
   * @param {object} query - The query to find the user.
   * @returns {Promise<User>} A promise that resolves with the user.
   */
  public async findOne(query: any): Promise<User> {
    return await this.db.user.findFirst({ where: query });
  }

  /**
   * Updates a user
   *
   * @param {string} id - the user id
   * @param {UpdateUserDto} updateUserDto - the user data to update
   * @returns {Promise<User>} - the updated user
   */
  public async update(id: string, updateUserDto: UpdateUserDto) {
    const user = await this.db.user.update({
      where: { id },
      data: updateUserDto,
    });
    return user;
  }

  /**
   * Removes a user
   *
   * @param {User} user - the user to remove
   * @returns {Promise<User>} - the removed user
   */
  async remove(user: User) {
    if (this.configService.get('NODE_ENV') === 'development') {
      user = await this.db.user.delete({
        where: { id: user.id },
      });
      return user;
    }
    throw new ForbiddenException("Action can't be performed!");
  }
}
