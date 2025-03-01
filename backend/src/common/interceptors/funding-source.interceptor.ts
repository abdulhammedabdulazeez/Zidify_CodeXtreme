import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
  BadRequestException,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { CreateFundingSourceDto } from 'src/domains/funding-sources/dto/create-funding-source.dto';
import { JwtUser } from '../types';
import { UsersService } from 'src/users/users.service';

@Injectable()
export class FundingSourceConstraintsInterceptor implements NestInterceptor {
  constructor(private usersService: UsersService) {}
  async intercept(
    context: ExecutionContext,
    next: CallHandler,
  ): Promise<Observable<any>> {
    const request = context.switchToHttp().getRequest();
    const dto: CreateFundingSourceDto = request.body;
    const user: JwtUser = request.user;

    this.validateUniqueTypeField(dto);

    if (dto.type === 'momo') {
      this.validateMomoNumber(dto, user);
    }

    return next.handle();
  }

  private validateUniqueTypeField(dto: CreateFundingSourceDto) {
    const typeFields = {
      card: ['cardNumber', 'cardExpiry', 'cardHolder'],
      momo: ['momoNumber', 'momoName'],
    };

    const presentFields = typeFields[dto.type].filter(
      (field) => dto[field] !== undefined,
    );

    if (presentFields.length === 0) {
      throw new BadRequestException(
        `At least one ${dto.type} specific field must be provided`,
      );
    }

    const otherTypeFields = Object.keys(typeFields)
      .filter((type) => type !== dto.type)
      .flatMap((type) => typeFields[type]);

    const conflictingFields = otherTypeFields.filter(
      (field) => dto[field] !== undefined,
    );

    if (conflictingFields.length > 0) {
      throw new BadRequestException(
        `Cannot provide fields for other funding source types: ${conflictingFields.join(', ')}`,
      );
    }
  }

  private validateMomoNumber(dto: CreateFundingSourceDto, user: JwtUser) {
    if (dto.momoNumber !== user.phoneNumber) {
      throw new BadRequestException(
        "Momo number must match user's phone number",
      );
    }
  }
}
