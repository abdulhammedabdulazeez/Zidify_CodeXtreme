import { Module } from '@nestjs/common';
import { FundDestService } from './fund-dest.service';
import { FundDestController } from './fund-dest.controller';
import { DatabaseService } from 'src/database/database.service';
import { UsersService } from 'src/users/users.service';
import { SaveBoxModule } from '../save-box/save-box.module';

@Module({
  controllers: [FundDestController],
  providers: [FundDestService, DatabaseService, UsersService],
  imports: [SaveBoxModule],
})
export class FundDestModule {}
