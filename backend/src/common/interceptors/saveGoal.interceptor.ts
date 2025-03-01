import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { SAVEGOALSFREQUENCY } from '@prisma/client';
import { CreateSaveGoalDto } from 'src/domains/save-goal/dto/create-save-goal.dto';
import { AutoSaveService } from 'src/shared/services/autosave.service';

@Injectable()
export class SaveGoalInterceptor implements NestInterceptor {
  constructor(private readonly autoSaveService: AutoSaveService) {}
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    const request = context.switchToHttp().getRequest();
    const dto: CreateSaveGoalDto = request.body;

    // Validate funding source for non-manual frequencies
    this.autoSaveService.validateFundingSource(
      dto.autoSaveFrequency,
      dto.fundingSourceId,
      dto.fundingSourceType,
    );

    // Compute nextAutoSave date if frequency is not manual
    if (dto.autoSaveFrequency !== SAVEGOALSFREQUENCY.manual) {
      const autoSaveOptions = {
        startDate: dto.goalStartDate,
        endDate: dto.goalEndDate,
        autoSaveTime: dto.autoSaveTime,
        autoSaveFrequency: dto.autoSaveFrequency,
        autoSaveDayOfTheWeek: dto.autoSaveDayOfTheWeek,
        autoSaveDayOfTheMonth: dto.autoSaveDayOfTheMonth,
      };
      dto.nextAutoSave =
        this.autoSaveService.computeNextAutoSave(autoSaveOptions);
    }

    return next.handle();
  }
}
