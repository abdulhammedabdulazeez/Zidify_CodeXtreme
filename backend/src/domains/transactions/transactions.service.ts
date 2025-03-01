import { BadRequestException, Injectable, Logger } from '@nestjs/common';
import {
  CreateDepositTransactionDto,
  CreateTransactionDto,
} from './dto/create-transaction.dto';
import { UpdateTransactionDto } from './dto/update-transaction.dto';
import { DatabaseService } from 'src/database/database.service';
import {
  ACTIVITYCATEGORY,
  LockBox,
  SaveBox,
  SaveGoal,
  TRANSACTIONSTATUS,
} from '@prisma/client';
import { ActivityService, UserSavingsTotalService } from 'src/shared/services';
import { ActivityType, DepositDestinationType } from 'src/common/types';
import { ACTIVITYDESCRIPTIONS } from 'src/shared/constants';

enum TransactionType {
  DEPOSIT = 'deposit',
  WITHDRAWAL = 'withdrawal',
}

type DestinationType = SaveBox | SaveGoal | LockBox;

interface TransactionSourceType {
  id: string;
  balance?: number;
  goalAmountSaved?: number;
  lockAmount?: number;
}

@Injectable()
export class TransactionKeyMapper {
  getSourceKey(source: TransactionSourceType): string {
    if ('balance' in source && source.balance !== undefined) return 'saveBoxId';
    if ('goalAmountSaved' in source && source.goalAmountSaved !== undefined)
      return 'saveGoalId';
    if ('lockAmount' in source && source.lockAmount !== undefined)
      return 'lockBoxId';
    throw new BadRequestException('Invalid source type');
  }

  getDestinationKey(destination: TransactionSourceType): string {
    if ('balance' in destination && destination.balance !== undefined)
      return 'saveBoxId';
    if (
      'goalAmountSaved' in destination &&
      destination.goalAmountSaved !== undefined
    )
      return 'saveGoalId';
    if ('lockAmount' in destination && destination.lockAmount !== undefined)
      return 'lockBoxId';
    throw new BadRequestException('Invalid destination type');
  }

  getActivityCategory(field: string): ACTIVITYCATEGORY {
    const categoryMap = {
      saveBoxId: ACTIVITYCATEGORY.savebox,
      saveGoalId: ACTIVITYCATEGORY.savegoal,
      lockBoxId: ACTIVITYCATEGORY.lockbox,
    };
    return categoryMap[field] ?? ACTIVITYCATEGORY.savebox;
  }
}

@Injectable()
export class TransactionsService {
  constructor(
    private db: DatabaseService,
    private userSavingsTotalService: UserSavingsTotalService,
    private activityService: ActivityService,
    private readonly keyMapper: TransactionKeyMapper,
  ) {}

  private readonly logger = new Logger(TransactionsService.name);

  /**
   * Record a deposit transaction.
   * @param {CreateDepositTransactionDto} dto - The deposit transaction details.
   * @param {DepositDestinationType} destination - The destination of the deposit.
   * @returns {Promise<any>} - The recorded transaction.
   * @throws {BadRequestException} - If the destination is invalid.
   * @throws {Error} - If an error occurs during the transaction.
   */
  public async recordDepositTransaction(
    dto: CreateDepositTransactionDto,
    destination: DepositDestinationType,
  ) {
    return await this.db.$transaction(async (tx) => {
      const transactionData = {
        ...dto,
        status: TRANSACTIONSTATUS.success,
        [this.keyMapper.getDestinationKey(destination)]: destination.id,
      };

      return this.processDepositTransaction(transactionData, tx, destination);
    });
  }

  public async recordWithdrawalTransaction(dto: any) {
    return await this.db.$transaction(async (tx) => {
      const source = await this.validateWithdrawalSource(dto, tx);

      if (!dto.extWithdrawalDestinationId) {
        throw new BadRequestException(
          'External withdrawal destination is required',
        );
      }

      const destination = await tx.fundDestination.findUnique({
        where: {
          id: dto.extWithdrawalDestinationId,
          type: dto.extWithdrawalType,
        },
      });

      if (!destination) {
        throw new BadRequestException('Invalid withdrawal destination');
      }

      const transactionData = {
        ...dto,
        status: TRANSACTIONSTATUS.success,
        [this.keyMapper.getSourceKey(source)]: source.id,
      };

      return this.processTransaction(transactionData, tx, source);
    });
  }

  private async validateWithdrawalSource(
    dto: CreateTransactionDto,
    tx: any,
  ): Promise<DestinationType> {
    let source;

    if (dto.saveBoxId) {
      source = await tx.saveBox.findUnique({
        where: {
          id: dto.saveBoxId,
          userId: dto.userId,
        },
      });
    } else if (dto.saveGoalId) {
      source = await tx.saveGoal.findUnique({
        where: { id: dto.saveGoalId, userId: dto.userId },
      });
    } else if (dto.lockBoxId) {
      source = await tx.lockBox.findUnique({
        where: { id: dto.lockBoxId, userId: dto.userId },
      });
    } else {
      throw new BadRequestException('No valid withdrawal source specified');
    }
    return source;
  }

  private async processDepositTransaction(
    transactionData: CreateDepositTransactionDto,
    tx: any,
    destination: DestinationType,
  ) {
    const transaction = await tx.transaction.create({
      data: transactionData,
    });

    await Promise.all([
      this.updateTotalSavings(transaction, transactionData, tx, destination),
      this.createActivityRecord(
        transactionData,
        destination,
        TransactionType.DEPOSIT,
      ),
    ]);

    return transaction;
  }

  private async createActivityRecord(
    transactionData: CreateDepositTransactionDto | CreateTransactionDto,
    source: DestinationType,
    type: TransactionType,
  ): Promise<void> {
    const sourceKey = this.keyMapper.getSourceKey(source);
    const activityData: ActivityType = {
      userId: transactionData.userId,
      description:
        type === TransactionType.DEPOSIT
          ? ACTIVITYDESCRIPTIONS.DEPOSIT
          : ACTIVITYDESCRIPTIONS.WITHDRAWAL,
      category: this.keyMapper.getActivityCategory(sourceKey),
      amount: transactionData.amount,
      [sourceKey]: source.id,
    };
    await this.activityService.create(activityData);
  }

  private async processTransaction(
    transactionData: CreateTransactionDto,
    tx: any,
    source: DestinationType,
  ) {
    const transaction = await tx.transaction.create({
      data: transactionData,
    });

    await Promise.all([
      this.updateTotalSavings(transaction, transactionData, tx, source),
      this.createActivityRecord(
        transactionData,
        source,
        TransactionType.WITHDRAWAL,
      ),
    ]);

    return transaction;
  }

  async updateTotalSavings(
    transaction: any,
    transactionData: CreateDepositTransactionDto | CreateTransactionDto,
    tx: any,
    entity: DestinationType,
  ): Promise<void> {
    const key =
      transactionData.type === TransactionType.DEPOSIT
        ? this.keyMapper.getDestinationKey(entity)
        : this.keyMapper.getSourceKey(entity);

    const amount =
      transactionData.type === TransactionType.DEPOSIT
        ? transactionData.amount
        : -transactionData.amount;

    await this.userSavingsTotalService.update(
      transaction.userId,
      key,
      amount,
      tx,
    );
  }

  async findAllUserTransactions(userId: string) {
    return await this.db.transaction.findMany({
      where: { userId },
      include: {
        saveBox: true,
        saveGoal: true,
        lockBox: true,
        extWithdrawalDestination: true,
      },
    });
  }

  async findOne(id: string) {
    return await this.db.transaction.findUnique({
      where: { id },
      include: {
        saveBox: true,
        saveGoal: true,
        lockBox: true,
        extWithdrawalDestination: true,
      },
    });
  }

  async update(id: string, updateTransactionDto: UpdateTransactionDto) {
    return await this.db.transaction.update({
      where: { id },
      data: updateTransactionDto,
    });
  }

  async remove(id: string) {
    return await this.db.transaction.delete({
      where: { id },
    });
  }
}
