import { IsOptional, IsString, IsBoolean, IsNumber } from 'class-validator';

/**
 * @class Contains all optionnal data of a user, which are not required when creating an account.
 * essentially everything that need to be updated will go here. This way it's structured and we know what is being updated...etc
 */
export class AdditionalUserDto {
  @IsOptional()
  @IsNumber()
  dob: Date;

  @IsOptional()
  @IsString()
  address: string;

  @IsOptional()
  @IsString()
  identificationType: string;

  @IsOptional()
  @IsString()
  identificationNumber: string;

  @IsOptional()
  @IsString()
  nationality: string;

  @IsOptional()
  @IsString()
  occupation: string;

  @IsOptional()
  @IsBoolean()
  verified: boolean;

  @IsOptional()
  @IsNumber()
  passwordChangedAt: Date;

  @IsOptional()
  @IsNumber()
  passwordResetOtp: number;

  @IsOptional()
  @IsNumber()
  passwordResetOtpExpiry: Date;

  @IsOptional()
  @IsString()
  refreshToken?: string;

  @IsOptional()
  @IsString()
  emailVerificationToken: string;

  @IsOptional()
  @IsString()
  emailVerificationTokenExpiry: Date;
}
