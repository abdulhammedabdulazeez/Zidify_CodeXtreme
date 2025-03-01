import { Injectable } from '@nestjs/common';
import { OpenAI } from 'openai';
import * as fs from 'fs';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class OpenaiService extends OpenAI {
  constructor(private readonly config: ConfigService) {
    super({
      apiKey: config.get<string>('OPENAI_API_KEY'),
    });
  }
}

@Injectable()
export class WordService {
  constructor(
    private readonly openai: OpenaiService,
    private readonly config: ConfigService,
  ) {}

  // private async generateWordMeaningAndUsages(wordText: string, user: User) {
  async generateWordMeaningAndUsages(wordText: string) {
    const threadId = this.config.get<string>('THREAD_ID');
    await this.openai.beta.threads.messages.create(threadId, {
      role: 'user',
      content: wordText,
    });
    await this.openai.beta.threads.runs.create(threadId, {
      assistant_id: this.config.get<string>('ASST_ID'),
    });

    const intervalId = setInterval(async () => {
      const response = await this.openai.beta.threads.messages.list(threadId);
      const lastMessage = response.data[0];
      const result = lastMessage.content[0]['text']['value'];

      if (result) {
        // await this.createWordFromAIResult(result, wordText, user);
        clearInterval(intervalId);
        console.log(result);
      }
    }, 20000);

    return;
  }

  private async createWordFromAIResult(result) {
    fs.appendFileSync('word-meaning-and-usages.txt', result + '\n');

    const meaningRegex = /Meaning:(.*?)(?=Sentences:)/s;
    const usageRegex = /Sentences:(.*)/s;
    const sentenceRegex = /\d+\. "(.*?)"/g;

    const meaning: string = result.match(meaningRegex)[1].trim();
    const usageMatch = result.match(usageRegex)[1].trim();
    const usages = [];
    let match;
    while ((match = sentenceRegex.exec(usageMatch)) !== null) {
      usages.push(match[1].trim());
    }

    return;
  }
}
