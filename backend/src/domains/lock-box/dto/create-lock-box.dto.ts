import { SAVINGSFUNDINGSOURCETYPE } from '@prisma/client';
import { Transform } from 'class-transformer';
import {
  IsDateString,
  IsEnum,
  IsNumber,
  IsOptional,
  IsString,
} from 'class-validator';

export class CreateLockBoxDto {
  @IsString()
  title: string;

  @IsNumber()
  lockAmount: number;

  @IsOptional()
  @IsNumber()
  lockInterestRate: number;

  @IsDateString({ strict: true })
  @Transform(({ value }) => new Date(value).toISOString())
  lockEndDate: Date;

  @IsEnum(SAVINGSFUNDINGSOURCETYPE)
  fundingSourceType: SAVINGSFUNDINGSOURCETYPE;

  @IsString()
  fundingSourceId: string;
}
