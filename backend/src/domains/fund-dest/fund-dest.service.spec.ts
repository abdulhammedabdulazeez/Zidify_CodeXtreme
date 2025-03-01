import { Test, TestingModule } from '@nestjs/testing';
import { FundDestService } from './fund-dest.service';

describe('FundDestService', () => {
  let service: FundDestService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [FundDestService],
    }).compile();

    service = module.get<FundDestService>(FundDestService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
