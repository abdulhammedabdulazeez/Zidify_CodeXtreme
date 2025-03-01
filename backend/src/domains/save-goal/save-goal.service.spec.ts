import { Test, TestingModule } from '@nestjs/testing';
import { SaveGoalService } from './save-goal.service';

describe('SaveGoalService', () => {
  let service: SaveGoalService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [SaveGoalService],
    }).compile();

    service = module.get<SaveGoalService>(SaveGoalService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
