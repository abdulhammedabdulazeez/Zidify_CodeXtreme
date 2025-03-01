import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  HttpCode,
  HttpStatus,
  UseInterceptors,
} from '@nestjs/common';
import { SaveBoxService } from './save-box.service';
import { UpdateSaveBoxDto } from './dto/update-save-box.dto';
import { CurrentUser } from 'src/common/decorators';
import {
  DepositSaveBoxDto,
  WithdrawSaveBoxDto,
} from './dto/deposit-save-box.dto';
import { SaveBoxAutoSaveDto } from './dto/auto-save.dto';
import {
  SaveBoxAutoSaveInterceptor,
  SaveBoxDepositInterceptor,
  SaveBoxWithdrawalInterceptor,
} from 'src/common/interceptors';

@Controller('saveboxes')
export class SaveBoxController {
  constructor(private readonly saveBoxService: SaveBoxService) {}

  // @Get()
  // findAll() {
  //   return this.saveBoxService.findAll();
  // }

  @Post(':id/deposit')
  @HttpCode(HttpStatus.OK)
  @UseInterceptors(SaveBoxDepositInterceptor)
  deposit(
    @Param('id') saveBoxId: string,
    @CurrentUser('id') userId: string,
    @Body() dto: DepositSaveBoxDto,
  ) {
    return this.saveBoxService.deposit(userId, saveBoxId, dto);
  }

  @Post(':id/withdraw')
  @HttpCode(HttpStatus.OK)
  @UseInterceptors(SaveBoxWithdrawalInterceptor)
  withdraw(
    @Param('id') saveBoxId: string,
    @CurrentUser('id') userId: string,
    @Body() dto: WithdrawSaveBoxDto,
  ) {
    return this.saveBoxService.withdraw(userId, saveBoxId, dto);
  }

  @Patch(':id/auto-save')
  @HttpCode(HttpStatus.OK)
  @UseInterceptors(SaveBoxAutoSaveInterceptor)
  updateAutoSave(
    @Param('id') saveBoxId: string,
    @CurrentUser('id') userId: string,
    @Body() dto: SaveBoxAutoSaveDto,
  ) {
    return this.saveBoxService.updateAutoSave(userId, saveBoxId, dto);
  }

  @Get()
  findUserSaveBox(@CurrentUser('id') userId: string) {
    return this.saveBoxService.findUserSaveBox(userId);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.saveBoxService.findOne(id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateSaveBoxDto: UpdateSaveBoxDto) {
    return this.saveBoxService.update(+id, updateSaveBoxDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.saveBoxService.remove(+id);
  }
}
