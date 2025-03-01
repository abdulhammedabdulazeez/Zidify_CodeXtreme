import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseInterceptors,
} from '@nestjs/common';
import { FundingSourcesService } from './funding-sources.service';
import { CreateFundingSourceDto } from './dto/create-funding-source.dto';
import { UpdateFundingSourceDto } from './dto/update-funding-source.dto';
import { CurrentUser } from 'src/common/decorators';
import { FundingSourceConstraintsInterceptor } from 'src/common/interceptors';

@Controller('funding-sources')
export class FundingSourcesController {
  constructor(private readonly fundingSourcesService: FundingSourcesService) {}

  @Post()
  @UseInterceptors(FundingSourceConstraintsInterceptor)
  create(@CurrentUser('id') userId, @Body() dto: CreateFundingSourceDto) {
    return this.fundingSourcesService.create(dto, userId);
  }

  @Get()
  findAll(@CurrentUser('id') userId: string) {
    return this.fundingSourcesService.findAll(userId);
  }

  @Get(':id')
  findOne(@CurrentUser('id') userId: string, @Param('id') id: string) {
    return this.fundingSourcesService.findOne(id, userId);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateFundingSourceDto: UpdateFundingSourceDto,
  ) {
    return this.fundingSourcesService.update(+id, updateFundingSourceDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.fundingSourcesService.remove(+id);
  }
}
