import { Module } from '@nestjs/common';
import {
  TransactionsService,
  TransactionKeyMapper,
} from './transactions.service';
import { TransactionsController } from './transactions.controller';
import { DatabaseService } from 'src/database/database.service';
import { SaveBoxService } from '../save-box/save-box.service';
import { UsersService } from 'src/users/users.service';
import { SharedModule } from 'src/shared/shared.module';
import { ActivityService } from 'src/shared/services';

@Module({
  controllers: [TransactionsController],
  imports: [SharedModule],
  providers: [
    TransactionsService,
    UsersService,
    DatabaseService,
    SaveBoxService,
    ActivityService,
    TransactionKeyMapper,
  ],
  exports: [TransactionsService, TransactionKeyMapper],
})
export class TransactionsModule {}
