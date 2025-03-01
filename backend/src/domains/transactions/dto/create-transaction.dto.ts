import { PartialType, PickType } from '@nestjs/mapped-types';
import {
  ALLFUNDINGSOURCETYPE,
  TRANSACTIONSTATUS,
  TRANSACTIONTYPE,
} from '@prisma/client';
import { IsString, IsNumber, IsOptional, IsEnum } from 'class-validator';

export class CreateTransactionDto {
  @IsNumber()
  amount: number;

  @IsOptional()
  @IsString()
  userId: string;

  @IsOptional()
  @IsString()
  saveBoxId?: string;

  @IsOptional()
  @IsString()
  saveGoalId?: string;

  @IsOptional()
  @IsString()
  lockBoxId?: string;

  // only if type is withdrawal
  @IsOptional()
  @IsString()
  extWithdrawalDestinationId: string | null;

  @IsOptional()
  @IsString()
  sourceId?: string;

  @IsEnum(TRANSACTIONTYPE)
  type: TRANSACTIONTYPE;

  @IsEnum(ALLFUNDINGSOURCETYPE)
  methodOfFunding: ALLFUNDINGSOURCETYPE;

  @IsOptional()
  @IsString()
  description?: string;

  @IsOptional()
  @IsString()
  reference?: string;

  // @IsEnum(TRANSACTIONSTATUS)
  // status: 'pending' | 'success' | 'failed';

  @IsOptional()
  metadata?: Record<string, any>;
}

export class CreateDepositTransactionDto extends PickType(
  CreateTransactionDto,
  [
    'type',
    'userId',
    'amount',
    'saveBoxId',
    'saveGoalId',
    'lockBoxId',
    'sourceId',
    'methodOfFunding',
  ],
) {}
