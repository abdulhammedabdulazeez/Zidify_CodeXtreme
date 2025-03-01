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
import { FundDestService } from './fund-dest.service';
import { CreateFundDestDto } from './dto/create-fund-dest.dto';
import { UpdateFundDestDto } from './dto/update-fund-dest.dto';
import { FundDestinationConstraintsInterceptor } from 'src/common/interceptors/fund-dest.interceptor';
import { CurrentUser } from 'src/common/decorators';

@Controller('fund-destionations')
export class FundDestController {
  constructor(private readonly fundDestService: FundDestService) {}

  @Post()
  @UseInterceptors(FundDestinationConstraintsInterceptor)
  create(
    @CurrentUser('id') userId: string,
    @Body() createFundDestDto: CreateFundDestDto,
  ) {
    return this.fundDestService.create(createFundDestDto, userId);
  }

  @Get()
  findAll(@CurrentUser('id') userId: string) {
    return this.fundDestService.findAll(userId);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.fundDestService.findOne(id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateFundDestDto: UpdateFundDestDto,
  ) {
    return this.fundDestService.update(+id, updateFundDestDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.fundDestService.remove(+id);
  }
}
