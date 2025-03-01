import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { UsersService } from 'src/users/users.service';
import { DatabaseService } from 'src/database/database.service';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { PassportModule } from '@nestjs/passport';
import { JwtStrategy } from './strategies/jwt.strategy';
import { SaveBoxModule } from 'src/domains/save-box/save-box.module';

@Module({
  controllers: [AuthController],
  imports: [PassportModule, SaveBoxModule],
  providers: [
    AuthService,
    UsersService,
    DatabaseService,
    ConfigService,
    JwtService,
    JwtStrategy,
  ],
})
export class AuthModule {}
