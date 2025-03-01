import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { DatabaseService } from 'src/database/database.service';
import { SaveBoxModule } from 'src/domains/save-box/save-box.module';

@Module({
  controllers: [UsersController],
  providers: [UsersService, DatabaseService],
  exports: [UsersService],
  imports: [SaveBoxModule],
})
export class UsersModule {}
