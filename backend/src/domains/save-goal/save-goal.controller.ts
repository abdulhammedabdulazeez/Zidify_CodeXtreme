import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseInterceptors,
  HttpCode,
  HttpStatus,
} from '@nestjs/common';
import { SaveGoalService } from './save-goal.service';
import { CreateSaveGoalDto } from './dto/create-save-goal.dto';
import { UpdateSaveGoalDto } from './dto/update-save-goal.dto';
import { CurrentUser } from 'src/common/decorators';
import {
  SaveGoalDepositInterceptor,
  SaveGoalInterceptor,
} from 'src/common/interceptors';
import { DepositSaveGoalDto } from './dto/deposit-save-goal.dto';

@Controller('savegoals')
export class SaveGoalController {
  constructor(private readonly saveGoalService: SaveGoalService) {}

  @Post()
  @UseInterceptors(SaveGoalInterceptor)
  create(
    @CurrentUser('id') userId: string,
    @Body() createSaveGoalDto: CreateSaveGoalDto,
  ) {
    return this.saveGoalService.create(createSaveGoalDto, userId);
  }

  @Get()
  findAll(@CurrentUser('id') userId: string) {
    return this.saveGoalService.findAll(userId);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.saveGoalService.findOne(id);
  }

  @Post(':id/fund')
  @HttpCode(HttpStatus.OK)
  @UseInterceptors(SaveGoalDepositInterceptor)
  deposit(
    @Param('id') saveGoalId: string,
    @CurrentUser('id') userId: string,
    @Body() dto: DepositSaveGoalDto,
  ) {
    return this.saveGoalService.deposit(userId, saveGoalId, dto);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateSaveGoalDto: UpdateSaveGoalDto,
  ) {
    return this.saveGoalService.update(+id, updateSaveGoalDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.saveGoalService.remove(+id);
  }
}
