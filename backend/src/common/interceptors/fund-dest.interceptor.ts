import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
  BadRequestException,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { JwtUser } from '../types';
import { UsersService } from 'src/users/users.service';
import { CreateFundDestDto } from 'src/domains/fund-dest/dto/create-fund-dest.dto';

@Injectable()
export class FundDestinationConstraintsInterceptor implements NestInterceptor {
  constructor(private usersService: UsersService) {}
  async intercept(
    context: ExecutionContext,
    next: CallHandler,
  ): Promise<Observable<any>> {
    const request = context.switchToHttp().getRequest();
    const dto: CreateFundDestDto = request.body;
    const user: JwtUser = request.user;

    this.validateUniqueTypeField(dto);

    if (dto.type === 'momo') {
      this.validateMomoNumber(dto, user);
    }

    return next.handle();
  }

  private validateUniqueTypeField(dto: CreateFundDestDto) {
    const typeFields = {
      bank: ['accountName', 'bankName', 'accountNumber'],
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
        `Cannot provide fields for other fund withdrawal types: ${conflictingFields.join(', ')}`,
      );
    }
  }

  private validateMomoNumber(dto: CreateFundDestDto, user: JwtUser) {
    if (dto.momoNumber !== user.phoneNumber) {
      throw new BadRequestException(
        "Momo number must match user's phone number",
      );
    }
  }
}
