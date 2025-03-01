import { PartialType } from '@nestjs/mapped-types';
import { CreateSaveGoalDto } from './create-save-goal.dto';

export class UpdateSaveGoalDto extends PartialType(CreateSaveGoalDto) {}
