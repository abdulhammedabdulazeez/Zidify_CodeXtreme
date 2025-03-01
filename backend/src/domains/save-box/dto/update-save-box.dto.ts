import { PartialType } from '@nestjs/mapped-types';
import { CreateSaveBoxDto } from './create-save-box.dto';

export class UpdateSaveBoxDto extends PartialType(CreateSaveBoxDto) {}
