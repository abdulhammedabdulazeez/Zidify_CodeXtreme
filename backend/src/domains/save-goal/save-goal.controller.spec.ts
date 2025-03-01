import { Test, TestingModule } from '@nestjs/testing';
import { SaveGoalController } from './save-goal.controller';
import { SaveGoalService } from './save-goal.service';

describe('SaveGoalController', () => {
  let controller: SaveGoalController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [SaveGoalController],
      providers: [SaveGoalService],
    }).compile();

    controller = module.get<SaveGoalController>(SaveGoalController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
