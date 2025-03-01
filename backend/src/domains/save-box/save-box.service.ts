import { Injectable } from '@nestjs/common';
import { CreateSaveBoxDto } from './dto/create-save-box.dto';
import { UpdateSaveBoxDto } from './dto/update-save-box.dto';
import { ALLFUNDINGSOURCETYPE, SaveBox, TRANSACTIONTYPE } from '@prisma/client';
import { DatabaseService } from 'src/database/database.service';
import {
  DepositSaveBoxDto,
  WithdrawSaveBoxDto,
} from './dto/deposit-save-box.dto';
import {
  CreateDepositTransactionDto,
  CreateTransactionDto,
} from '../transactions/dto/create-transaction.dto';
import { TransactionsService } from '../transactions/transactions.service';
import { SaveBoxAutoSaveDto } from './dto/auto-save.dto';

@Injectable()
export class SaveBoxService {
  constructor(
    private readonly db: DatabaseService,
    private readonly transactionsService: TransactionsService,
  ) {}
  /**
   * Create a SaveBox for a new user.
   * This SaveBox is attached to the user's account when a user signs up.
   *
   * @param {string} userId - The ID of the user whose SaveBox is being created and attached.
   * @returns {Promise<SaveBox>} - The newly created SaveBox.
   */
  public async create(dto: CreateSaveBoxDto): Promise<SaveBox> {
    const saveBox = await this.db.saveBox.create({
      data: dto,
    });
    return saveBox;
  }

  /**
   * Deposit funds into a user's SaveBox.
   *
   * @param {string} userId - The ID of the user whose SaveBox is being deposited into.
   * @param {string} saveBoxId - The ID of the SaveBox being deposited into.
   * @param {DepositSaveBoxDto} dto - The deposit details.
   */
  async deposit(userId: string, saveBoxId: string, dto: DepositSaveBoxDto) {
    const saveBox = await this.incrementBalance(saveBoxId, userId, dto.amount);
    // UPDATE TRANSACTION IN BACKGROUND
    const transactionDto: CreateDepositTransactionDto = {
      ...dto,
      saveBoxId,
      userId,
      type: TRANSACTIONTYPE.deposit,
    };

    this.transactionsService.recordDepositTransaction(transactionDto, saveBox);
    return saveBox;
  }

  /**
   * Withdraw funds from a user's SaveBox.
   *
   * @param {string} userId - The ID of the user whose SaveBox is being withdrawn from.
   * @param {string} saveBoxId - The ID of the SaveBox being withdrawn from.
   * @param {WithdrawSaveBoxDto} dto - The withdrawal details.
   */
  async withdraw(userId: string, saveBoxId: string, dto: WithdrawSaveBoxDto) {
    const saveBox = await this.decrementBalance(saveBoxId, userId, dto.amount);

    // UPDATE TRANSACTION IN BACKGROUND
    const transactionDto: CreateDepositTransactionDto = {
      ...dto,
      methodOfFunding: ALLFUNDINGSOURCETYPE.savebox,
      saveBoxId,
      userId,
      type: TRANSACTIONTYPE.withdrawal,
    };

    this.transactionsService.recordWithdrawalTransaction(transactionDto);
    return saveBox;
  }

  /**
   * Decrease the balance of a SaveBox.
   * @param id - The ID of the SaveBox to update.
   * @param userId - The ID of the user who owns the SaveBox.
   * @param amount - The amount to decrement the balance by.
   * @private
   * @memberof SaveBoxService
   * @returns {Promise<SaveBox>} - The updated SaveBox.
   */
  private async decrementBalance(
    id: string,
    userId: string,
    amount: number,
  ): Promise<SaveBox> {
    return await this.db.saveBox.update({
      where: { id, userId },
      data: {
        balance: {
          decrement: amount,
        },
      },
    });
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
  private async incrementBalance(id: string, userId: string, amount: number) {
    return await this.db.saveBox.update({
      where: { id, userId },
      data: {
        balance: {
          increment: amount,
        },
      },
    });
  }

  /**
   * Update auto-save for a user's SaveBox.
   *
   * @param {string} userId - The ID of the user whose SaveBox is being updated for auto-save.
   * @param {string} saveBoxId - The ID of the SaveBox being updated for auto-save.
   * @param {SaveBoxAutoSaveDto} dto - The auto-save details.
   */
  async updateAutoSave(
    userId: string,
    saveBoxId: string,
    dto: SaveBoxAutoSaveDto,
  ) {
    return dto.enabled
      ? await this.enableAutoSave(userId, saveBoxId, dto)
      : await this.disableAutoSave(userId, saveBoxId, dto);
  }

  /**
   * Disable auto-save for a user's SaveBox.
   *
   * @param {string} userId - The ID of the user whose SaveBox is being disabled for auto-save.
   * @param {string} saveBoxId - The ID of the SaveBox being disabled for auto-save.
   */
  async disableAutoSave(
    userId: string,
    saveBoxId: string,
    dto: SaveBoxAutoSaveDto,
  ) {
    delete dto.enabled;
    return await this.db.saveBox.update({
      where: { id: saveBoxId, userId },
      data: {
        nextAutoSave: null,
        autoSaveStartDate: null,
        autoSaveEndDate: null,
        autoSaveEnabled: false,
      },
    });
  }

  /**
   * Enable auto-save for a user's SaveBox.
   *
   * @param {string} userId - The ID of the user whose SaveBox is being enabled for auto-save.
   * @param {string} saveBoxId - The ID of the SaveBox being enabled for auto-save.
   */
  async enableAutoSave(
    userId: string,
    saveBoxId: string,
    dto: SaveBoxAutoSaveDto,
  ) {
    delete dto.enabled;
    return await this.db.saveBox.update({
      where: { id: saveBoxId, userId },
      data: {
        ...dto,
        autoSaveEnabled: true,
      },
    });
  }

  findAll() {
    return `This action returns all saveBox`;
  }

  /**
   * Find a SaveBox by ID.
   * @param id - The ID of the SaveBox to find.
   * @returns { Promise<SaveBox> || Null } - The SaveBox with the specified ID.
   */
  async findOne(id: string) {
    return await this.db.saveBox.findUnique({
      where: { id },
    });
  }

  /**
   * Find a user's SaveBox.
   *
   * @param {string} userId - The ID of the user whose SaveBox is being queried.
   * @returns {Promise<SaveBox>} - The user's SaveBox.
   */
  async findUserSaveBox(userId: string) {
    const saveBox = await this.db.saveBox.findUnique({
      where: { userId }, //TODO: include activities
      include: { activities: true },
    });
    return saveBox;
  }

  update(id: number, updateSaveBoxDto: UpdateSaveBoxDto) {
    return `This action updates a #${id} saveBox`;
  }

  remove(id: number) {
    return `This action removes a #${id} saveBox`;
  }

  /**
   * Generate a unique 13-digit number.
   * The number is generated by combining a fixed prefix, the current timestamp, and random digits.
   *
   * @returns {string} - A unique 13-digit number.
   */
  public generateUnique13DigitNumber(): string {
    // Fixed starting digits
    const prefix = '200';

    // Get the current timestamp in milliseconds
    const timestamp = Date.now().toString();

    // Extract the last 10 digits of the timestamp
    const timestampPart = timestamp.slice(-10);

    // If the timestamp is less than 10 digits (rare), pad with random digits
    const randomPadding = Math.random().toString().slice(2, 12); // Generate 10 random digits

    // Combine the prefix with the timestamp part or random digits to ensure a total of 13 digits
    const uniqueNumber =
      prefix +
      (timestampPart.length === 10
        ? timestampPart
        : randomPadding.slice(0, 10 - timestampPart.length));

    return uniqueNumber;
  }
}
