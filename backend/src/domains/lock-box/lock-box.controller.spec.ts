import { Test, TestingModule } from '@nestjs/testing';
import { LockBoxController } from './lock-box.controller';
import { LockBoxService } from './lock-box.service';

describe('LockBoxController', () => {
  let controller: LockBoxController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [LockBoxController],
      providers: [LockBoxService],
    }).compile();

    controller = module.get<LockBoxController>(LockBoxController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
