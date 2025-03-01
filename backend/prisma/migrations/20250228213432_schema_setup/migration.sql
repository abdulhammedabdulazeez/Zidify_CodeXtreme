-- CreateEnum
CREATE TYPE "ROLE" AS ENUM ('user', 'super_admin');

-- CreateEnum
CREATE TYPE "AUTOSAVEFREQUENCY" AS ENUM ('daily', 'weekly', 'monthly');

-- CreateEnum
CREATE TYPE "SAVEGOALSFREQUENCY" AS ENUM ('daily', 'weekly', 'monthly', 'manual');

-- CreateEnum
CREATE TYPE "TRANSACTIONTYPE" AS ENUM ('deposit', 'withdrawal');

-- CreateEnum
CREATE TYPE "TRANSACTIONSTATUS" AS ENUM ('pending', 'success', 'failed');

-- CreateEnum
CREATE TYPE "FUNDINGSOURCETYPE" AS ENUM ('bank', 'card', 'momo');

-- CreateEnum
CREATE TYPE "SAVINGSFUNDINGSOURCETYPE" AS ENUM ('momo', 'card', 'savebox');

-- CreateEnum
CREATE TYPE "ALLFUNDINGSOURCETYPE" AS ENUM ('momo', 'card', 'savebox', 'bank');

-- CreateEnum
CREATE TYPE "WITHDRAWALDESTINATIONTYPE" AS ENUM ('bank', 'momo');

-- CreateEnum
CREATE TYPE "SAVINGSSTATUSTYPE" AS ENUM ('ongoing', 'completed');

-- CreateEnum
CREATE TYPE "ACTIVITYCATEGORY" AS ENUM ('account', 'savebox', 'savegoal', 'lockbox');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT,
    "phoneNumber" TEXT,
    "googleId" TEXT,
    "refreshToken" TEXT,
    "emailVerificationToken" TEXT,
    "emailVerificationTokenExpiry" TIMESTAMP(3),
    "passwordChangedAt" TIMESTAMP(3),
    "passwordResetOtp" INTEGER,
    "passwordResetOtpExpiry" TIMESTAMP(3),
    "role" "ROLE" NOT NULL DEFAULT 'user',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Profile" (
    "id" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "email" TEXT,
    "phoneNumber" TEXT,
    "isEmailVerified" BOOLEAN NOT NULL DEFAULT false,
    "isPhoneNumberVerified" BOOLEAN NOT NULL DEFAULT false,
    "dob" TIMESTAMP(3),
    "address" TEXT,
    "identificationType" TEXT,
    "identificationNumber" TEXT,
    "nationality" TEXT,
    "occupation" TEXT,
    "avatar" TEXT,
    "transactionPin" TEXT,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SaveBox" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "balance" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "accountNumber" TEXT NOT NULL,
    "accountName" TEXT,
    "autoSaveEnabled" BOOLEAN NOT NULL DEFAULT false,
    "autoSaveAmount" DOUBLE PRECISION,
    "autoSaveFrequency" "AUTOSAVEFREQUENCY",
    "autoSaveDayOfTheWeek" INTEGER,
    "autoSaveDayOfTheMonth" INTEGER,
    "autoSaveTime" TEXT,
    "autoSaveFundingSourceId" TEXT,
    "autoSaveFundingSourceType" TEXT,
    "autoSaveStartDate" TIMESTAMP(3),
    "autoSaveEndDate" TIMESTAMP(3),
    "nextAutoSave" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SaveBox_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SaveGoal" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "status" "SAVINGSSTATUSTYPE" NOT NULL DEFAULT 'ongoing',
    "goalTargetAmount" DOUBLE PRECISION NOT NULL,
    "goalAmountSaved" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "goalStartDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "goalEndDate" TIMESTAMP(3),
    "goalName" TEXT NOT NULL,
    "goalDescription" TEXT,
    "goalCategory" TEXT,
    "autoSaveFrequency" "SAVEGOALSFREQUENCY" NOT NULL,
    "autoSaveAmount" DOUBLE PRECISION,
    "autoSaveDayOfTheWeek" INTEGER,
    "autoSaveDayOfTheMonth" INTEGER,
    "autoSaveTime" TEXT,
    "nextAutoSave" TIMESTAMP(3),
    "fundingSourceType" "SAVINGSFUNDINGSOURCETYPE",
    "fundingSourceId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SaveGoal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LockBox" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "status" "SAVINGSSTATUSTYPE" NOT NULL DEFAULT 'ongoing',
    "title" TEXT NOT NULL,
    "lockAmount" DOUBLE PRECISION NOT NULL,
    "lockInterestRate" DOUBLE PRECISION NOT NULL,
    "lockStartDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lockEndDate" TIMESTAMP(3) NOT NULL,
    "fundingSourceType" "SAVINGSFUNDINGSOURCETYPE" NOT NULL,
    "fundingSourceId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LockBox_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FundingSource" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "type" "ALLFUNDINGSOURCETYPE" NOT NULL,
    "accountNumber" TEXT,
    "bankName" TEXT,
    "accountName" TEXT,
    "cardNumber" TEXT,
    "cardExpiry" TEXT,
    "cardHolder" TEXT,
    "momoNumber" TEXT,
    "momoName" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "FundingSource_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FundDestination" (
    "id" TEXT NOT NULL,
    "type" "WITHDRAWALDESTINATIONTYPE" NOT NULL,
    "accountNumber" TEXT,
    "bankName" TEXT,
    "accountName" TEXT,
    "momoNumber" TEXT,
    "momoName" TEXT,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "FundDestination_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Transaction" (
    "id" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "userId" TEXT NOT NULL,
    "saveBoxId" TEXT,
    "saveGoalId" TEXT,
    "lockBoxId" TEXT,
    "extWithdrawalDestinationId" TEXT,
    "extWithdrawalType" "WITHDRAWALDESTINATIONTYPE",
    "sourceId" TEXT,
    "type" "TRANSACTIONTYPE" NOT NULL,
    "description" TEXT,
    "reference" TEXT,
    "status" "TRANSACTIONSTATUS" NOT NULL,
    "metadata" JSONB,
    "methodOfFunding" "ALLFUNDINGSOURCETYPE" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Transaction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserSavingsTotal" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "totalSaveGoals" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "totalLockBoxes" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "totalSaveBox" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "overallTotal" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserSavingsTotal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Activity" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "category" "ACTIVITYCATEGORY" NOT NULL,
    "description" TEXT NOT NULL,
    "saveBoxId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Activity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Tip" (
    "id" TEXT NOT NULL,
    "body" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Tip_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_phoneNumber_key" ON "User"("phoneNumber");

-- CreateIndex
CREATE INDEX "User_email_idx" ON "User"("email");

-- CreateIndex
CREATE INDEX "User_phoneNumber_idx" ON "User"("phoneNumber");

-- CreateIndex
CREATE UNIQUE INDEX "Profile_userId_key" ON "Profile"("userId");

-- CreateIndex
CREATE INDEX "Profile_userId_idx" ON "Profile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "SaveBox_userId_key" ON "SaveBox"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "SaveBox_accountNumber_key" ON "SaveBox"("accountNumber");

-- CreateIndex
CREATE UNIQUE INDEX "SaveBox_autoSaveFundingSourceId_key" ON "SaveBox"("autoSaveFundingSourceId");

-- CreateIndex
CREATE INDEX "SaveBox_userId_idx" ON "SaveBox"("userId");

-- CreateIndex
CREATE INDEX "LockBox_userId_idx" ON "LockBox"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "FundingSource_accountNumber_key" ON "FundingSource"("accountNumber");

-- CreateIndex
CREATE UNIQUE INDEX "FundingSource_cardNumber_key" ON "FundingSource"("cardNumber");

-- CreateIndex
CREATE UNIQUE INDEX "FundingSource_momoNumber_key" ON "FundingSource"("momoNumber");

-- CreateIndex
CREATE INDEX "FundingSource_userId_idx" ON "FundingSource"("userId");

-- CreateIndex
CREATE INDEX "FundDestination_type_id_idx" ON "FundDestination"("type", "id");

-- CreateIndex
CREATE INDEX "Transaction_saveBoxId_idx" ON "Transaction"("saveBoxId");

-- CreateIndex
CREATE INDEX "Transaction_userId_idx" ON "Transaction"("userId");

-- CreateIndex
CREATE INDEX "Transaction_status_idx" ON "Transaction"("status");

-- CreateIndex
CREATE UNIQUE INDEX "UserSavingsTotal_userId_key" ON "UserSavingsTotal"("userId");

-- CreateIndex
CREATE INDEX "UserSavingsTotal_userId_idx" ON "UserSavingsTotal"("userId");

-- AddForeignKey
ALTER TABLE "Profile" ADD CONSTRAINT "Profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SaveBox" ADD CONSTRAINT "SaveBox_autoSaveFundingSourceId_fkey" FOREIGN KEY ("autoSaveFundingSourceId") REFERENCES "FundingSource"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SaveBox" ADD CONSTRAINT "SaveBox_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SaveGoal" ADD CONSTRAINT "SaveGoal_fundingSourceId_fkey" FOREIGN KEY ("fundingSourceId") REFERENCES "FundingSource"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SaveGoal" ADD CONSTRAINT "SaveGoal_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LockBox" ADD CONSTRAINT "LockBox_fundingSourceId_fkey" FOREIGN KEY ("fundingSourceId") REFERENCES "FundingSource"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LockBox" ADD CONSTRAINT "LockBox_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FundingSource" ADD CONSTRAINT "FundingSource_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FundDestination" ADD CONSTRAINT "FundDestination_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_extWithdrawalDestinationId_fkey" FOREIGN KEY ("extWithdrawalDestinationId") REFERENCES "FundDestination"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_saveBoxId_fkey" FOREIGN KEY ("saveBoxId") REFERENCES "SaveBox"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_saveGoalId_fkey" FOREIGN KEY ("saveGoalId") REFERENCES "SaveGoal"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_lockBoxId_fkey" FOREIGN KEY ("lockBoxId") REFERENCES "LockBox"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSavingsTotal" ADD CONSTRAINT "UserSavingsTotal_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Activity" ADD CONSTRAINT "Activity_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Activity" ADD CONSTRAINT "Activity_saveBoxId_fkey" FOREIGN KEY ("saveBoxId") REFERENCES "SaveBox"("id") ON DELETE SET NULL ON UPDATE CASCADE;
