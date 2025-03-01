import { Module } from '@nestjs/common';
import { SaveBoxService } from './save-box.service';
import { SaveBoxController } from './save-box.controller';
import { DatabaseService } from 'src/database/database.service';
import { SharedModule } from 'src/shared/shared.module';
import { TransactionsModule } from '../transactions/transactions.module';
import { FundingSourcesService } from '../funding-sources/funding-sources.service';
import { UsersService } from 'src/users/users.service';

@Module({
  controllers: [SaveBoxController],
  imports: [SharedModule, TransactionsModule],
  providers: [
    SaveBoxService,
    DatabaseService,
    FundingSourcesService,
    UsersService,
  ],
  exports: [SaveBoxService],
})
export class SaveBoxModule {}
