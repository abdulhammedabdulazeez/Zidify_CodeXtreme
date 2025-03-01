import {
  SAVEGOALSFREQUENCY,
  SAVINGSFUNDINGSOURCETYPE,
  SAVINGSSTATUSTYPE,
  User,
} from '@prisma/client';

export class SaveGoal {
  id: string;
  userId: string;
  status: SAVINGSSTATUSTYPE = SAVINGSSTATUSTYPE.ongoing;

  goalTargetAmount: number;
  goalAmountSaved: number = 0;
  goalStartDate: Date = new Date();
  goalEndDate?: Date;
  goalName: string;
  goalDescription?: string;

  autoSaveFrequency: SAVEGOALSFREQUENCY;
  autoSaveAmount?: number;
  autoSaveDayOfTheWeek?: number;
  autoSaveDayOfTheMonth?: number;
  autoSaveTime?: string;
  nextAutoSave?: Date;

  fundingSourceType?: SAVINGSFUNDINGSOURCETYPE;
  fundingSourceId?: string;

  transactions: any[] = []; // Transaction[]
  fundingSource?: any; // FundingSource
  user: User;

  createdAt: Date = new Date();
  updatedAt: Date = new Date();

  constructor(data: Partial<SaveGoal> = {}) {
    Object.assign(this, data);
  }
}
