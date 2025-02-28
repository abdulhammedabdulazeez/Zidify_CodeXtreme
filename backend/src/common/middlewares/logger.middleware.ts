import { Injectable, Logger, NestMiddleware } from '@nestjs/common';
import { FastifyRequest, FastifyReply } from 'fastify';

@Injectable()
export class LoggerMiddleware implements NestMiddleware {
  logger = new Logger('Response');
  constructor() {
    this.use = this.use.bind(this);
  }
  use(req: FastifyRequest['raw'], res: FastifyReply['raw'], next: () => void) {
    const { method, url } = req;
    const requestTime = new Date().getTime();

    res.on('finish', () => {
      const { statusCode } = res;
      const responseTime = new Date().getTime();

      if (statusCode === 200 || statusCode === 201) {
        this.logger.log(
          `${method} ${url} ${statusCode} - ${responseTime - requestTime}ms`,
        );
      }
    });

    next();
  }
}
