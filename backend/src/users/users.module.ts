import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { DatabaseService } from 'src/database/database.service';
import { SaveBoxModule } from 'src/domains/save-box/save-box.module';
import { CaslModule } from 'src/casl/casl.module';

@Module({
  controllers: [UsersController],
  providers: [UsersService, DatabaseService],
  exports: [UsersService],
  imports: [SaveBoxModule, CaslModule],
})
export class UsersModule {}
