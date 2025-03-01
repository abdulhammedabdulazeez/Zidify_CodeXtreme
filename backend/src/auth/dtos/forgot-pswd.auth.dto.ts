import { PickType } from '@nestjs/mapped-types';
import { CreateUserDto } from 'src/users/dtos/create-user.dto';
import { LoginAuthDto } from './login-auth.dto';

/**
 * A data transfer object (DTO) used to perform forgot password action.
 * @class
 * @classdesc This class inherits email field from CreateUserDto.
 * @see CreateUserDto
 */
export class ForgotPasswordDto extends PickType(LoginAuthDto, [
  'email',
  'phoneNumber',
] as const) {}
