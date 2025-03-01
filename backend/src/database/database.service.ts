import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Prisma, PrismaClient } from '@prisma/client';

const configService = new ConfigService();
@Injectable()
/**
 * API DATABASE
 */
export class DatabaseService extends PrismaClient {
  constructor() {
    super({
      datasources: {
        db: {
          url: configService.getOrThrow<string>('DATABASE_URL'),
        },
      },
      // transactionOptions: {
      //   isolationLevel: Prisma.TransactionIsolationLevel.Serializable,
      // },
    });
  }
}
