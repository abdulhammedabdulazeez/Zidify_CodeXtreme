import { Test, TestingModule } from '@nestjs/testing';
import { SaveBoxController } from './save-box.controller';
import { SaveBoxService } from './save-box.service';

describe('SaveBoxController', () => {
  let controller: SaveBoxController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [SaveBoxController],
      providers: [SaveBoxService],
    }).compile();

    controller = module.get<SaveBoxController>(SaveBoxController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
