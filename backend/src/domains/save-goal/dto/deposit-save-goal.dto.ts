import {
  SAVINGSFUNDINGSOURCETYPE,
  WITHDRAWALDESTINATIONTYPE,
} from '@prisma/client';
import { IsEnum, IsNumber, IsString } from 'class-validator';

export class DepositSaveGoalDto {
  @IsNumber()
  amount: number;

  @IsString()
  sourceId: string;

  @IsEnum(SAVINGSFUNDINGSOURCETYPE)
  methodOfFunding: SAVINGSFUNDINGSOURCETYPE;
}

export class WithdrawSaveGoalDto {
  @IsNumber()
  amount: number;

  // @IsString()
  // sourceId: string;

  @IsString()
  extWithdrawalDestinationId: string;

  @IsEnum(WITHDRAWALDESTINATIONTYPE)
  extWithdrawalType: WITHDRAWALDESTINATIONTYPE;
}
