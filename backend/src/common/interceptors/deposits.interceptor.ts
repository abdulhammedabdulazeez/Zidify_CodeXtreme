import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
  BadRequestException,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { DatabaseService } from 'src/database/database.service';
import { FundingSourcesService } from 'src/domains/funding-sources/funding-sources.service';
import { DepositSaveBoxDto } from 'src/domains/save-box/dto/deposit-save-box.dto';
import { DepositSaveGoalDto } from 'src/domains/save-goal/dto/deposit-save-goal.dto';

@Injectable()
export class SaveBoxDepositInterceptor implements NestInterceptor {
  constructor(
    private readonly db: DatabaseService,
    private readonly fundingSourcesService: FundingSourcesService,
  ) {}
  async intercept(
    context: ExecutionContext,
    next: CallHandler,
  ): Promise<Observable<any>> {
    const request = context.switchToHttp().getRequest();
    const dto: DepositSaveBoxDto = request.body;
    const userId = request.user.id;
    const params = request.params;

    // RETURN ERROR IF FUNDING SOURCE DOES NOT EXIST
    const fundingSource = await this.fundingSourcesService.findOne(
      dto.sourceId,
      userId,
    );

    if (!fundingSource || fundingSource.type !== dto.methodOfFunding) {
      throw new BadRequestException('Invalid Funding source!');
    }

    // FIND SAVEBOX
    await this.db.saveBox.findUnique({
      where: { id: params.id },
    });

    return next.handle();
  }
}

@Injectable()
export class SaveGoalDepositInterceptor implements NestInterceptor {
  constructor(private readonly fundingSourcesService: FundingSourcesService) {}
  async intercept(
    context: ExecutionContext,
    next: CallHandler,
  ): Promise<Observable<any>> {
    const request = context.switchToHttp().getRequest();
    const dto: DepositSaveGoalDto = request.body;
    const userId = request.user.id;

    // RETURN ERROR IF FUNDING SOURCE DOES NOT EXIST
    const fundingSource = await this.fundingSourcesService.findOne(
      dto.sourceId,
      userId,
    );

    if (!fundingSource || fundingSource.type !== dto.methodOfFunding) {
      throw new BadRequestException('Invalid Funding source!');
    }

    return next.handle();
  }
}
