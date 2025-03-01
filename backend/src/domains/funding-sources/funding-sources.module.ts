import { Module } from '@nestjs/common';
import { FundingSourcesService } from './funding-sources.service';
import { FundingSourcesController } from './funding-sources.controller';
import { DatabaseService } from 'src/database/database.service';
import { UsersService } from 'src/users/users.service';
import { SaveBoxModule } from '../save-box/save-box.module';

@Module({
  controllers: [FundingSourcesController],
  providers: [FundingSourcesService, DatabaseService, UsersService],
  imports: [SaveBoxModule],
  exports: [FundingSourcesService],
})
export class FundingSourcesModule {}
