import { IsNotEmpty, IsString, ValidateIf } from 'class-validator';

export class LoginAuthDto {
  @IsString()
  @ValidateIf((o) => !o.phoneNumber)
  @IsNotEmpty({ message: 'Either email or phone number must be provided' })
  email?: string;

  @IsString()
  @ValidateIf((o) => !o.email)
  @IsNotEmpty({ message: 'Either email or phone number must be provided' })
  phoneNumber?: string;

  @IsString()
  @IsNotEmpty()
  password: string;
}
