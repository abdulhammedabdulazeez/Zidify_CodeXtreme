import { IsEnum, IsOptional, IsString } from 'class-validator';
import { ALLFUNDINGSOURCETYPE } from '@prisma/client';

export class CreateFundingSourceDto {
  @IsEnum(ALLFUNDINGSOURCETYPE)
  type: ALLFUNDINGSOURCETYPE;

  @IsOptional()
  @IsString()
  userId: string;

  @IsOptional()
  @IsString()
  cardNumber: string;

  @IsOptional()
  @IsString()
  cardExpiry: string;

  @IsOptional()
  @IsString()
  cardHolder: string;

  @IsOptional()
  @IsString()
  momoNumber: string;

  @IsOptional()
  @IsString()
  momoName: string;
}
