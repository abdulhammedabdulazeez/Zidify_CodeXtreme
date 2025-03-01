import { Test, TestingModule } from '@nestjs/testing';
import { FundDestController } from './fund-dest.controller';
import { FundDestService } from './fund-dest.service';

describe('FundDestController', () => {
  let controller: FundDestController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [FundDestController],
      providers: [FundDestService],
    }).compile();

    controller = module.get<FundDestController>(FundDestController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
