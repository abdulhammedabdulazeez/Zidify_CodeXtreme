import { WITHDRAWALDESTINATIONTYPE } from '@prisma/client';
import { IsEnum, IsOptional, IsString } from 'class-validator';

export class CreateFundDestDto {
  @IsEnum(WITHDRAWALDESTINATIONTYPE)
  type: WITHDRAWALDESTINATIONTYPE;

  @IsOptional()
  @IsString()
  accountNumber: string;

  @IsOptional()
  @IsString()
  bankName: string;

  @IsOptional()
  @IsString()
  accountName: string;

  @IsOptional()
  @IsString()
  momoNumber: string;

  @IsOptional()
  @IsString()
  momoName: string;
}
