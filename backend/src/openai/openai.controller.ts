import { Body, Controller, Post } from '@nestjs/common';
import { OpenaiService, WordService } from './openai.service';
import { IsNotEmpty, IsString } from 'class-validator';

export class PromptDto {
  @IsNotEmpty()
  @IsString()
  prompt: string; // Change this to match what your service expects
}

@Controller('openai')
export class OpenaiController {
  constructor(
    private readonly openai: OpenaiService,
    private word: WordService,
  ) {}

  @Post('advise')
  getHello(@Body() body: PromptDto): Promise<any> {
    return this.word.generateWordMeaningAndUsages(body.prompt);
  }
}
