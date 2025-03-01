import { Module } from '@nestjs/common';
import { DatabaseService } from '../database/database.service'; // Adjust the path
import { UserSavingsTotalService } from './services/userSavingsTotal.service';
import { AutoSaveService } from './services';

@Module({
  providers: [UserSavingsTotalService, AutoSaveService, DatabaseService],
  exports: [UserSavingsTotalService, AutoSaveService],
})
export class SharedModule {}
