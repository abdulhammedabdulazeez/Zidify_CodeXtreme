import { PickType } from '@nestjs/mapped-types';
import { IsNotEmpty, IsString } from 'class-validator';
import { CreateUserDto } from 'src/users/dtos/create-user.dto';

export class ChangePasswordDto extends PickType(CreateUserDto, ['password']) {
  @IsString()
  @IsNotEmpty()
  currentPassword: string;
}
