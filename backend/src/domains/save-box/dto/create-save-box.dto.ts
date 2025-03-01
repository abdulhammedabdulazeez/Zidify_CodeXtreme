import { IsOptional, IsString } from 'class-validator';

export class CreateSaveBoxDto {
  @IsString()
  userId: string;

  @IsString()
  accountNumber: string;

  @IsOptional()
  @IsString()
  accountName?: string;
}
