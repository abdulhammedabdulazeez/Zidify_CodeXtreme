import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { DatabaseModule } from './database/database.module';
import { ConfigModule } from '@nestjs/config';
import { UsersModule } from './users/users.module';
import { JwtGuard } from './common/guards/jwt.guard';
import { APP_FILTER, APP_GUARD } from '@nestjs/core';
import { SaveBoxModule } from './domains/save-box/save-box.module';
import { LockBoxModule } from './domains/lock-box/lock-box.module';
import { SaveGoalModule } from './domains/save-goal/save-goal.module';
import { TransactionsModule } from './domains/transactions/transactions.module';
import { FundingSourcesModule } from './domains/funding-sources/funding-sources.module';
import { FundDestModule } from './domains/fund-dest/fund-dest.module';
import { SharedModule } from './shared/shared.module';
import { ExceptionsFilter } from './common/exceptions';
import { OpenaiModule } from './openai/openai.module';

@Module({
  imports: [
    AuthModule,
    DatabaseModule,
    ConfigModule.forRoot({ isGlobal: true }),
    UsersModule,
    SaveBoxModule,
    LockBoxModule,
    SaveGoalModule,
    TransactionsModule,
    FundingSourcesModule,
    FundDestModule,
    SharedModule,
    OpenaiModule,
  ],
  controllers: [AppController],
  providers: [
    AppService,
    {
      provide: APP_GUARD,
      useClass: JwtGuard,
    },
    {
      provide: APP_FILTER,
      useClass: ExceptionsFilter,
    },
  ],
})
export class AppModule {}
