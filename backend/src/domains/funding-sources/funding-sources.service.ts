import { Injectable } from '@nestjs/common';
import { CreateFundingSourceDto } from './dto/create-funding-source.dto';
import { UpdateFundingSourceDto } from './dto/update-funding-source.dto';
import { DatabaseService } from 'src/database/database.service';
import { FundingSource } from '@prisma/client';

@Injectable()
export class FundingSourcesService {
  constructor(private readonly db: DatabaseService) {}

  /**
   * Create a new funding source
   * @param {CreateFundingSourceDto} dto - Funding source data
   * @param {string} userId - User id
   * @returns {Promise<FundingSource>}
   */
  async create(dto: CreateFundingSourceDto, userId: string) {
    const fundingSource = await this.db.fundingSource.create({
      data: {
        ...dto,
        userId,
      },
    });
    return fundingSource;
  }

  /**
   * Find all funding sources for a user
   * @param {string} userId - User id
   * @returns {Promise<FundingSource[]>}
   * @returns {Promise<FundingSource[]>}
   */
  async findAll(userId: string) {
    return await this.db.fundingSource.findMany({
      where: { userId },
    });
  }

  /**
   * Find one funding source by id
   * @param {string} id - Funding source id
   * @param {string} userId - User id
   * @returns {Promise<FundingSource>}
   */
  async findOne(id: string, userId: string) {
    const fundingSource = await this.db.fundingSource.findUnique({
      where: { id, userId },
    });
    return fundingSource;
  }

  update(id: number, updateFundingSourceDto: UpdateFundingSourceDto) {
    return `This action updates a #${id} fundingSource`;
  }

  remove(id: number) {
    return `This action removes a #${id} fundingSource`;
  }
}
