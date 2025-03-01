import {
  SAVINGSFUNDINGSOURCETYPE,
  SAVINGSSTATUSTYPE,
  User,
} from '@prisma/client';

export class LockBox {
  id: string;
  userId: string;
  status: SAVINGSSTATUSTYPE = SAVINGSSTATUSTYPE.ongoing;
  title: string;

  lockAmount: number;
  lockInterestRate: number;
  lockStartDate: Date = new Date();
  lockEndDate: Date;

  fundingSourceType: SAVINGSFUNDINGSOURCETYPE;
  fundingSourceId: string;

  transactions: any[] = []; // Transaction[]
  fundingSource: any; // FundingSource
  user: User;

  createdAt: Date = new Date();
  updatedAt: Date = new Date();

  constructor(data: Partial<LockBox> = {}) {
    Object.assign(this, data);
  }
}
