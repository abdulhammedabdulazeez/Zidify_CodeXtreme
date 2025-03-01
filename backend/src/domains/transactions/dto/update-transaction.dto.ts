import { PartialType } from '@nestjs/mapped-types';
import { CreateTransactionDto } from './create-transaction.dto';
import { IsEnum, IsOptional, IsString, IsNumber } from 'class-validator';
import { TRANSACTIONSTATUS } from '@prisma/client';

export class UpdateTransactionDto extends PartialType(CreateTransactionDto) {
  @IsOptional()
  @IsEnum(TRANSACTIONSTATUS)
  status?: TRANSACTIONSTATUS;

  @IsOptional()
  @IsString()
  description?: string;

  @IsOptional()
  @IsString()
  reference?: string;

  @IsOptional()
  metadata?: Record<string, any>;

  // For corrections or admin-level modifications
  @IsOptional()
  @IsNumber()
  amount?: number;
}
