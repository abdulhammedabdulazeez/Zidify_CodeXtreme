import { Injectable } from '@nestjs/common';
import { CreateSaveGoalDto } from './dto/create-save-goal.dto';
import { UpdateSaveGoalDto } from './dto/update-save-goal.dto';
import { DatabaseService } from 'src/database/database.service';
import { SaveGoal, TRANSACTIONTYPE } from '@prisma/client';
import { CreateDepositTransactionDto } from '../transactions/dto/create-transaction.dto';
import { DepositSaveGoalDto } from './dto/deposit-save-goal.dto';
import { TransactionsService } from '../transactions/transactions.service';

@Injectable()
export class SaveGoalService {
  constructor(
    private readonly db: DatabaseService,
    private readonly transactionsService: TransactionsService,
  ) {}

  /**
   * Create a SaveGoal for a user.
   * @param {CreateSaveGoalDto} dto - The details of the SaveGoal to create.
   * @param {string} userId - The ID of the user creating the SaveGoal.
   * @returns {Promise<SaveGoal>} - The newly created SaveGoal.
   * @memberof SaveGoalService
   */
  async create(dto: CreateSaveGoalDto, userId: string) {
    const saveGoal = await this.db.saveGoal.create({
      // @ts-ignore
      data: { ...dto, userId },
    });
    return saveGoal;
  }

  /**
   * Finds all SaveGoals for a user. Contains all SaveGoals created by the user, irrespective of the status.
   *
   * @param {string} userId - the user id to query against the database
   * @returns {Promise<SaveGoal[]>} - array of user's SaveGoals.
   */
  async findAll(userId: string): Promise<SaveGoal[]> {
    const saveGoals = await this.db.saveGoal.findMany({
      where: {
        userId,
      },
    });

    return saveGoals;
  }

  /**
   * Find a SaveGoal by ID.
   * @param id - The ID of the SaveGoal to find.
   * @returns { Promise<SaveGoal> || Null } - The SaveGoal with the specified ID.
   */
  async findOne(id: string) {
    return await this.db.saveGoal.findUnique({
      where: { id },
    });
  }

  /**
   * Deposit funds into a user's SaveBox.
   *
   * @param {string} userId - The ID of the user whose SaveBox is being deposited into.
   * @param {string} saveGoalId - The ID of the SaveBox being deposited into.
   * @param {DepositSaveBoxDto} dto - The deposit details.
   */
  async deposit(userId: string, saveGoalId: string, dto: DepositSaveGoalDto) {
    const saveGoal = await this._incrementBalance(
      saveGoalId,
      userId,
      dto.amount,
    );
    // UPDATE TRANSACTION IN BACKGROUND
    const transactionDto: CreateDepositTransactionDto = {
      ...dto,
      saveGoalId,
      userId,
      type: TRANSACTIONTYPE.deposit,
    };

    this.transactionsService.recordDepositTransaction(transactionDto, saveGoal);
    return saveGoal;
  }

  /**
   * Increase the balance of a SaveBox.
   * @param id - The ID of the SaveBox to update.
   * @param userId - The ID of the user who owns the SaveBox.
   * @param amount - The amount to increment the balance by.
   * @returns {Promise<SaveBox>} - The updated SaveBox.
   * @private
   * @memberof SaveBoxService
   * @returns {Promise<SaveBox>} - The updated SaveBox.
   */
  private async _incrementBalance(id: string, userId: string, amount: number) {
    return await this.db.saveGoal.update({
      where: { id, userId },
      data: {
        goalAmountSaved: {
          increment: amount,
        },
      },
    });
  }

  update(id: number, updateSaveGoalDto: UpdateSaveGoalDto) {
    return `This action updates a #${id} saveGoal`;
  }

  remove(id: number) {
    return `This action removes a #${id} saveGoal`;
  }
}
