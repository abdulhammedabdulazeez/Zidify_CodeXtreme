import { Test, TestingModule } from '@nestjs/testing';
import { LockBoxService } from './lock-box.service';

describe('LockBoxService', () => {
  let service: LockBoxService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [LockBoxService],
    }).compile();

    service = module.get<LockBoxService>(LockBoxService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
