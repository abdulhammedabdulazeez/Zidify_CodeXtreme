import { Module } from '@nestjs/common';
import { SaveGoalService } from './save-goal.service';
import { SaveGoalController } from './save-goal.controller';
import { DatabaseService } from 'src/database/database.service';
import { AutoSaveService } from 'src/shared/services';
import { FundingSourcesService } from '../funding-sources/funding-sources.service';
import { TransactionsModule } from '../transactions/transactions.module';
import { UsersService } from 'src/users/users.service';
import { SaveBoxModule } from '../save-box/save-box.module';

@Module({
  controllers: [SaveGoalController],
  imports: [TransactionsModule, SaveBoxModule],
  providers: [
    SaveGoalService,
    DatabaseService,
    AutoSaveService,
    FundingSourcesService,
    UsersService,
  ],
})
export class SaveGoalModule {}
