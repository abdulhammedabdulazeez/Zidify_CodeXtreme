import { Injectable } from '@nestjs/common';
import { ActivityType } from 'src/common/types';
import { DatabaseService } from 'src/database/database.service';

@Injectable()
export class ActivityService {
  constructor(private readonly db: DatabaseService) {}

  public async create(data: ActivityType) {
    await this.db.activity.create({ data });
    return;
  }
}
