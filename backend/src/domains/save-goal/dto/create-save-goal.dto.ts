import { SAVEGOALSFREQUENCY, SAVINGSFUNDINGSOURCETYPE } from '@prisma/client';
import { Transform } from 'class-transformer';
import {
  IsDateString,
  IsEnum,
  IsNumber,
  IsOptional,
  IsString,
} from 'class-validator';

export class CreateSaveGoalDto {
  @IsOptional()
  @IsString()
  userId: string;

  @IsOptional()
  @IsString()
  fundingSourceId: string;

  @IsOptional()
  @IsEnum(SAVINGSFUNDINGSOURCETYPE)
  fundingSourceType: SAVINGSFUNDINGSOURCETYPE;

  @IsNumber()
  goalTargetAmount: number;

  @IsOptional()
  @IsDateString({ strict: true })
  @Transform(({ value }) => new Date(value).toISOString())
  goalStartDate: Date;

  @IsOptional()
  @IsDateString({ strict: true })
  @Transform(({ value }) => new Date(value).toISOString())
  goalEndDate: Date;

  @IsOptional()
  @IsString()
  goalDescription: Date;

  @IsOptional()
  @IsString()
  goalCategory: string;

  @IsString()
  goalName: string;

  @IsEnum(SAVEGOALSFREQUENCY)
  autoSaveFrequency: SAVEGOALSFREQUENCY;

  @IsOptional()
  @IsNumber()
  autoSaveAmount: number;

  @IsOptional()
  @IsNumber()
  autoSaveDayOfTheWeek: number;

  @IsOptional()
  @IsNumber()
  autoSaveDayOfTheMonth: number;

  @IsOptional()
  @IsString()
  autoSaveTime: string;

  @IsOptional()
  @IsDateString()
  @Transform(({ value }) => new Date(value).toISOString())
  nextAutoSave: Date;
}
