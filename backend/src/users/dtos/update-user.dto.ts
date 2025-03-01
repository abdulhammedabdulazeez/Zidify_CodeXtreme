import { CreateUserDto } from './create-user.dto';
import { IntersectionType, PartialType } from '@nestjs/mapped-types';
import { AdditionalUserDto } from './additional-user.dto';

export class UpdateUserDto extends PartialType(
  IntersectionType(CreateUserDto, AdditionalUserDto),
) {}
