import {
  ALLFUNDINGSOURCETYPE,
  WITHDRAWALDESTINATIONTYPE,
} from '@prisma/client';
import { IsEnum, IsNumber, IsString } from 'class-validator';

export class DepositSaveBoxDto {
  @IsNumber()
  amount: number;

  @IsString()
  sourceId: string;

  @IsEnum(ALLFUNDINGSOURCETYPE)
  methodOfFunding: ALLFUNDINGSOURCETYPE;
}

export class WithdrawSaveBoxDto {
  @IsNumber()
  amount: number;

  // @IsString()
  // sourceId: string;

  @IsString()
  extWithdrawalDestinationId: string;

  @IsEnum(WITHDRAWALDESTINATIONTYPE)
  extWithdrawalType: WITHDRAWALDESTINATIONTYPE;
}
