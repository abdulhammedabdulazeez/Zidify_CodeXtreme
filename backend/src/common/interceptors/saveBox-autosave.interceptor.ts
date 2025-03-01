import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
  BadRequestException,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { AutoSaveService } from 'src/shared/services/autosave.service';
import { SaveBoxAutoSaveDto } from 'src/domains/save-box/dto/auto-save.dto';

@Injectable()
export class SaveBoxAutoSaveInterceptor implements NestInterceptor {
  constructor(private readonly autoSaveService: AutoSaveService) {}

  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    const request = context.switchToHttp().getRequest();
    const dto: SaveBoxAutoSaveDto = request.body;

    if (!dto.enabled) {
      return next.handle();
    }

    // Validate frequency-specific fields
    this.autoSaveService.validateFrequencyFields({
      frequency: dto.autoSaveFrequency,
      dayOfWeek: dto.autoSaveDayOfTheWeek,
      dayOfMonth: dto.autoSaveDayOfTheMonth,
      time: dto.autoSaveTime,
      startDate: dto.autoSaveStartDate,
    });

    // Validate funding source for autosave frequencies
    this.autoSaveService.validateFundingSource(
      dto.autoSaveFrequency,
      dto.autoSaveFundingSourceId,
      dto.autoSaveFundingSourceType,
    );

    const autoSaveOptions = {
      startDate: dto.autoSaveStartDate || new Date(),
      endDate: dto.autoSaveEndDate || new Date('9999-12-31T23:59:59.999Z'),
      autoSaveTime: dto.autoSaveTime,
      autoSaveFrequency: dto.autoSaveFrequency,
      autoSaveDayOfTheWeek: dto.autoSaveDayOfTheWeek,
      autoSaveDayOfTheMonth: dto.autoSaveDayOfTheMonth,
    };

    dto.nextAutoSave =
      this.autoSaveService.computeNextAutoSave(autoSaveOptions);
    dto.autoSaveStartDate = autoSaveOptions.startDate;
    dto.autoSaveEndDate = autoSaveOptions.endDate;

    if (!dto.nextAutoSave || isNaN(dto.nextAutoSave.getTime())) {
      throw new BadRequestException('Invalid next auto-save date computed');
    }

    return next.handle();
  }
}
