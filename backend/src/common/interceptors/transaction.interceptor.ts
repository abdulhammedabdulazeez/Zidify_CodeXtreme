import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
  BadRequestException,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { CreateTransactionDto } from 'src/domains/transactions/dto/create-transaction.dto';

const commonRequiredFields = ['amount', 'methodOfFunding'];

@Injectable()
export class DepositValidationInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    const request = context.switchToHttp().getRequest();
    const body: CreateTransactionDto = request.body;

    // Add user id to the transaction
    body.userId = request.user.id;

    if (body.type !== 'deposit') {
      throw new BadRequestException('Transaction must be deposit');
    }

    // Validate destination exists
    if (!body.lockBoxId && !body.saveBoxId && !body.saveGoalId) {
      throw new BadRequestException(
        'Deposit must have one of: lockBoxId, saveBoxId, or saveGoalId',
      );
    }

    // Check required fields
    for (const field of commonRequiredFields) {
      if (!body[field]) {
        throw new BadRequestException(
          `Missing required deposit field: ${field}`,
        );
      }
    }

    // Withdrawal-specific fields should not be present in deposits
    const invalidFields = ['extWithdrawalDestinationId'];

    for (const field of invalidFields) {
      if (body[field]) {
        throw new BadRequestException(
          `Deposit should not include field: ${field}`,
        );
      }
    }

    return next.handle();
  }
}

@Injectable()
export class WithdrawalValidationInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    const request = context.switchToHttp().getRequest();
    const body: CreateTransactionDto = request.body;

    // Add user id to the transaction
    body.userId = request.user.id;

    if (body.type !== 'withdrawal') {
      throw new BadRequestException('Transaction type must be withdrawal');
    }

    // Validate source exists
    if (!body.saveBoxId && !body.saveGoalId && !body.lockBoxId) {
      throw new BadRequestException(
        'Withdrawal must have a source: saveBoxId, saveGoalId, or lockBoxId',
      );
    }

    // Check common required fields
    for (const field of commonRequiredFields) {
      if (!body[field]) {
        throw new BadRequestException(
          `Missing required withdrawal field: ${field}`,
        );
      }
    }

    // Validate external withdrawal destination
    if (!body.extWithdrawalDestinationId) {
      throw new BadRequestException(
        'Withdrawal must include extWithdrawalDestinationId',
      );
    }

    return next.handle();
  }
}
