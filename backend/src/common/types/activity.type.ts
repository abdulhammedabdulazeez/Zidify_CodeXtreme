import { ACTIVITYCATEGORY } from '@prisma/client';

export type ActivityType = {
  amount?: number;
  userId: string;
  description: string;
  category: ACTIVITYCATEGORY;
  saveBoxId?: string;
};
