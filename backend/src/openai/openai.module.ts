import { Module } from '@nestjs/common';
import { OpenaiService, WordService } from './openai.service';
import { OpenaiController } from './openai.controller';
import { ConfigModule } from '@nestjs/config'; // If you need configuration

@Module({
  imports: [
    // Import other modules that provide services you need
    ConfigModule, // If you need configuration
  ],
  controllers: [OpenaiController],
  providers: [OpenaiService, WordService],
  exports: [OpenaiService], // If you need to use this service in other modules
})
export class OpenaiModule {}
