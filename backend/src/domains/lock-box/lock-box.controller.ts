import { Controller, Get, Post, Body, Param, Delete } from '@nestjs/common';
import { LockBoxService } from './lock-box.service';
import { CreateLockBoxDto } from './dto/create-lock-box.dto';
import { CurrentUser } from 'src/common/decorators';

@Controller('lockboxes')
export class LockBoxController {
  constructor(private readonly lockBoxService: LockBoxService) {}

  @Post()
  create(@CurrentUser('id') userId: string, @Body() dto: CreateLockBoxDto) {
    return this.lockBoxService.create(dto, userId);
  }

  @Get()
  findAll(@CurrentUser('id') userId: string) {
    return this.lockBoxService.findAll(userId);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.lockBoxService.findOne(id);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.lockBoxService.remove(+id);
  }
}
