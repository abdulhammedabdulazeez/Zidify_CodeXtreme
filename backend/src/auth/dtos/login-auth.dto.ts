import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsOptional, IsString, ValidateIf } from 'class-validator';

export class LoginAuthDto {
  @ApiProperty({ required: false })
  @IsString()
  @ValidateIf((o) => !o.phoneNumber)
  @IsNotEmpty({ message: 'Either email or phone number must be provided' })
  email?: string;

  @ApiProperty({ required: false })
  @IsString()
  @ValidateIf((o) => !o.email)
  @IsNotEmpty({ message: 'Either email or phone number must be provided' })
  phoneNumber?: string;

  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  password: string;
}
