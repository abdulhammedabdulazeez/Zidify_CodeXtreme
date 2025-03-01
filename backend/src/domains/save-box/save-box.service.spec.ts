import { Test, TestingModule } from '@nestjs/testing';
import { SaveBoxService } from './save-box.service';

describe('SaveBoxService', () => {
  let service: SaveBoxService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [SaveBoxService],
    }).compile();

    service = module.get<SaveBoxService>(SaveBoxService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
