import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
  BadRequestException,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { DatabaseService } from 'src/database/database.service';
import { WithdrawSaveBoxDto } from 'src/domains/save-box/dto/deposit-save-box.dto';

@Injectable()
export class SaveBoxWithdrawalInterceptor implements NestInterceptor {
  constructor(private readonly db: DatabaseService) {}
  async intercept(
    context: ExecutionContext,
    next: CallHandler,
  ): Promise<Observable<any>> {
    const request = context.switchToHttp().getRequest();
    const dto: WithdrawSaveBoxDto = request.body;
    const userId = request.user.id;
    const params = request.params;

    const source = await this.db.saveBox.findUnique({
      where: {
        id: params.id,
        userId,
      },
    });
    if (!source || source.balance < dto.amount) {
      throw new BadRequestException(
        'Insufficient funds in SaveBox for withdrawal',
      );
    }

    return next.handle();
  }
}

@Injectable()
export class SaveGoalWithdrawalInterceptor implements NestInterceptor {
  constructor(private readonly db: DatabaseService) {}
  async intercept(
    context: ExecutionContext,
    next: CallHandler,
  ): Promise<Observable<any>> {
    const request = context.switchToHttp().getRequest();
    const dto: WithdrawSaveBoxDto = request.body;
    const userId = request.user.id;
    const params = request.params;

    const source = await this.db.saveBox.findUnique({
      where: {
        id: params.id,
        userId,
      },
    });
    if (!source || source.balance < dto.amount) {
      throw new BadRequestException(
        'Insufficient funds in SaveBox for withdrawal',
      );
    }

    return next.handle();
  }
}
