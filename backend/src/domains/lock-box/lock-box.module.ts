import { Module } from '@nestjs/common';
import { LockBoxService } from './lock-box.service';
import { LockBoxController } from './lock-box.controller';
import { DatabaseService } from 'src/database/database.service';

@Module({
  controllers: [LockBoxController],
  providers: [LockBoxService, DatabaseService],
})
export class LockBoxModule {}
