import { Injectable } from '@nestjs/common';
import { DatabaseService } from 'src/database/database.service';

enum SAVINGSTOTALKEYS {
  'saveGoalId' = 'totalSaveGoals',
  'saveGoal' = 'totalSaveGoals',
  'saveBoxId' = 'totalSaveBox',
  'saveBox' = 'totalSaveBox',
  'lockBoxId' = 'totalLockBoxes',
  'lockBox' = 'totalLockBoxes',
}

@Injectable()
export class UserSavingsTotalService {
  constructor(private db: DatabaseService) {}

  async findUserSavingsTotal(userId: string) {
    return await this.db.userSavingsTotal.findUnique({
      where: { userId },
    });
  }

  async update(userId: string, category: string, amount: number, tx: any) {
    return await tx.userSavingsTotal.update({
      where: { userId },
      data: {
        overallTotal: { increment: amount },
        [SAVINGSTOTALKEYS[category]]: { increment: amount },
      },
    });
  }
}
