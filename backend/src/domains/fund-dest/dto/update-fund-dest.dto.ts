import { PartialType } from '@nestjs/mapped-types';
import { CreateFundDestDto } from './create-fund-dest.dto';

export class UpdateFundDestDto extends PartialType(CreateFundDestDto) {}
