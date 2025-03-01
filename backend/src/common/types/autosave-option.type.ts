import { AUTOSAVEFREQUENCY, SAVEGOALSFREQUENCY } from '@prisma/client';

export type AutoSaveOptions = {
  startDate: Date;
  endDate: Date;
  autoSaveTime: string;
  autoSaveFrequency: SAVEGOALSFREQUENCY | AUTOSAVEFREQUENCY;
  autoSaveDayOfTheWeek: number;
  autoSaveDayOfTheMonth: number;
};
