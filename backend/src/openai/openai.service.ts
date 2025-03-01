import { Injectable } from '@nestjs/common';
import { OpenAI } from 'openai';
import * as fs from 'fs';

@Injectable()
export class OpenaiService extends OpenAI {
  constructor() {
    super({
      apiKey:
        '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',
    });
  }
}

@Injectable()
export class WordService {
  constructor(private readonly openai: OpenaiService) {}

  // private async generateWordMeaningAndUsages(wordText: string, user: User) {
  async generateWordMeaningAndUsages(wordText: string) {
    const threadId = 'thread_pDl9ywtEjdb9yPYcd47wcXOw';
    await this.openai.beta.threads.messages.create(threadId, {
      role: 'user',
      content: wordText,
    });
    await this.openai.beta.threads.runs.create(threadId, {
      assistant_id: 'asst_7jM5pDUO793ZLbgUCMsTnjDF',
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
