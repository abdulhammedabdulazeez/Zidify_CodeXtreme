import {
  ROLE,
  SaveBox,
  LockBox,
  SaveGoal,
  Activity,
  FundDestination,
  FundingSource,
  UserSavingsTotal,
} from '@prisma/client';

export class User {
  id: string;
  email: string;
  firstName: string;
  lastName: string;
  password?: string;
  phoneNumber?: string;

  dob?: Date;
  address?: string;
  identificationType?: string;
  identificationNumber?: string;
  nationality?: string;
  occupation?: string;

  googleId?: string;
  avatar?: string;
  isEmailVerified: boolean = false;
  isPhoneNumberVerified: boolean = false;

  verified: boolean = false;
  refreshToken?: string;
  emailVerificationToken?: string;
  emailVerificationTokenExpiry?: Date;
  passwordChangedAt?: Date;
  passwordResetOtp?: number;
  passwordResetOtpExpiry?: Date;

  role: ROLE = ROLE.user;

  saveBox?: SaveBox;
  lockBoxes: LockBox[] = [];
  saveGoals: SaveGoal[] = [];

  paymentMethods: FundingSource[] = []; // FundingSource[]
  userSavingsTotal?: UserSavingsTotal; // UserSavingsTotal
  activities: Activity[] = []; // Activity[]
  fundDestinations: FundDestination[] = []; // FundDestination[]

  createdAt: Date = new Date();
  updatedAt: Date = new Date();

  constructor(data: Partial<User> = {}) {
    Object.assign(this, data);
  }
}
