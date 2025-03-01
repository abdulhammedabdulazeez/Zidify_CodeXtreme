import { Injectable } from '@nestjs/common';
import { CreateFundDestDto } from './dto/create-fund-dest.dto';
import { UpdateFundDestDto } from './dto/update-fund-dest.dto';
import { DatabaseService } from 'src/database/database.service';

@Injectable()
export class FundDestService {
  constructor(private readonly db: DatabaseService) {}

  /**
   * create a new fund destination for a user (e.g. withdrawal bank account, mobile money)
   * @param dto - the fund destination details
   * @param userId - the user id
   * @returns {FundDestination} - the created fund destination
   */
  async create(dto: CreateFundDestDto, userId: string) {
    return await this.db.fundDestination.create({
      data: {
        ...dto,
        userId,
      },
    });
  }

  /**
   * find all fund destinations for a user
   * @param userId - the user id
   * @returns {FundDestination[]} - all fund destinations for the user
   */
  async findAll(userId: string) {
    return await this.db.fundDestination.findMany({
      where: { userId },
    });
  }

  /**
   * Find one fund destination by id
   * @param id - the fund destination id
   * @returns {FundDestination} - the fund destination
   */
  async findOne(id: string) {
    return await this.db.fundDestination.findUnique({
      where: { id },
    });
  }

  update(id: number, updateFundDestDto: UpdateFundDestDto) {
    return `This action updates a #${id} fundDest`;
  }

  remove(id: number) {
    return `This action removes a #${id} fundDest`;
  }
}
