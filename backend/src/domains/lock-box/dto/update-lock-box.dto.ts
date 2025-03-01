import { PartialType } from '@nestjs/mapped-types';
import { CreateLockBoxDto } from './create-lock-box.dto';

export class UpdateLockBoxDto extends PartialType(CreateLockBoxDto) {}
