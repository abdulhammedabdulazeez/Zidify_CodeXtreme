import { Injectable } from '@nestjs/common';
import { CreateLockBoxDto } from './dto/create-lock-box.dto';
import { DatabaseService } from 'src/database/database.service';
import { LockBox } from '@prisma/client';

@Injectable()
export class LockBoxService {
  constructor(private readonly db: DatabaseService) {}

  /**
   * Creates a lockbox for a user.
   *
   * @param {CreateLockBoxDto} dto - the lockbox data to create.
   * @param {string} userId - the user id to associate the lockbox with.
   * @returns {Promise<LockBox>} - the created lockbox.
   */
  async create(dto: CreateLockBoxDto, userId: string) {
    dto.lockInterestRate = 0.05;
    return await this.db.lockBox.create({
      data: {
        ...dto,
        userId,
      },
    });
  }

  /**
   * Finds all lockboxes for a user. Contains all lockboxes created by the user, irrespective of the status.
   *
   * @param {string} userId - the user id to query against the database
   * @returns {Promise<LockBox[]>} - array of lockboxes for the user.
   */
  async findAll(userId: string): Promise<LockBox[]> {
    return await this.db.lockBox.findMany({
      where: {
        userId,
      },
    });
  }

  /**
   * Find a lockbox by ID.
   * @param id - The ID of the lockbox to find.
   * @returns { Promise<LockBox> || Null } - The lockbox with the specified ID.
   */
  async findOne(id: string) {
    return await this.db.lockBox.findUnique({
      where: { id },
    });
  }

  remove(id: number) {
    return `This action removes a #${id} lockBox`;
  }
}
