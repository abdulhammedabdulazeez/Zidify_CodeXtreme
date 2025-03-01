import { LockBox, SaveBox, SaveGoal } from '@prisma/client';

export type DepositDestinationType = SaveBox | SaveGoal | LockBox;
