import { AUTOSAVEFREQUENCY, SAVINGSFUNDINGSOURCETYPE } from '@prisma/client';
import { Transform } from 'class-transformer';
import {
  IsBoolean,
  IsDateString,
  IsEnum,
  IsNumber,
  IsOptional,
  IsString,
  ValidateIf,
} from 'class-validator';

export class SaveBoxAutoSaveDto {
  @IsBoolean()
  enabled: boolean;

  @IsNumber()
  autoSaveAmount: number;

  @IsEnum(AUTOSAVEFREQUENCY)
  autoSaveFrequency: AUTOSAVEFREQUENCY;

  @ValidateIf((o) => o.autoSaveFrequency === 'weekly')
  @IsNumber()
  @Transform(({ value }) => Number(value))
  autoSaveDayOfTheWeek?: number = null;

  @ValidateIf((o) => o.autoSaveFrequency === 'monthly')
  @IsNumber()
  @Transform(({ value }) => Number(value))
  autoSaveDayOfTheMonth?: number = null;

  @ValidateIf((o) => o.enabled === true)
  @IsString()
  autoSaveTime: string = '00:00';

  @ValidateIf((o) => o.enabled === true)
  @IsString()
  autoSaveFundingSourceId: string;

  @ValidateIf((o) => o.enabled === true)
  @IsEnum(SAVINGSFUNDINGSOURCETYPE)
  autoSaveFundingSourceType: SAVINGSFUNDINGSOURCETYPE;

  @IsOptional()
  @Transform(({ value }) => {
    if (!value) return undefined;
    const date = new Date(value);
    if (isNaN(date.getTime())) return undefined;
    return date.toISOString();
  })
  @IsDateString()
  autoSaveStartDate?: Date;

  @IsOptional()
  @Transform(({ value }) => {
    if (!value) return undefined;
    const date = new Date(value);
    if (isNaN(date.getTime())) return undefined;
    return date.toISOString();
  })
  @IsDateString()
  autoSaveEndDate?: Date;

  @IsOptional()
  nextAutoSave?: Date;
}
