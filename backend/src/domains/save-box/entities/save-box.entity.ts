import { AUTOSAVEFREQUENCY, User } from '@prisma/client';

export class SaveBox {
  id: string;
  userId: string;
  balance: number = 0;
  accountNumber: string;
  accountName: string;

  autoSaveEnabled: boolean = false;
  autoSaveAmount?: number;
  autoSaveFrequency?: AUTOSAVEFREQUENCY;
  autoSaveDayOfTheWeek?: number;
  autoSaveDayOfTheMonth?: number;
  autoSaveTime?: string;
  autoSaveFundingSourceId?: string;
  autoSaveFundingSourceType?: string;
  autoSaveStartDate?: Date;
  autoSaveEndDate?: Date;
  nextAutoSave?: Date;

  transactions: any[] = []; // Transaction[]
  activities: any[] = []; // Activity[]

  autoSaveFundingSource?: any; // FundingSource
  user: User;

  createdAt: Date = new Date();
  updatedAt: Date = new Date();

  constructor(data: Partial<SaveBox> = {}) {
    Object.assign(this, data);
  }
}
