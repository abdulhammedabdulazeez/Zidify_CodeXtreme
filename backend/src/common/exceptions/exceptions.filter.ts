import {
  ArgumentsHost,
  Catch,
  ExceptionFilter,
  HttpException,
  HttpStatus,
  Logger,
} from '@nestjs/common';
import { FastifyRequest, FastifyReply } from 'fastify';

@Catch(HttpException, Error)
export class ExceptionsFilter implements ExceptionFilter {
  private readonly logger = new Logger(ExceptionsFilter.name);

  catch(exception: any, host: ArgumentsHost): void {
    const ctx = host.switchToHttp();
    const request = ctx.getRequest<FastifyRequest>();
    const response = ctx.getResponse<FastifyReply>();

    let status = HttpStatus.INTERNAL_SERVER_ERROR;
    let message: any = 'Internal server error';

    if (exception instanceof HttpException) {
      status = exception.getStatus();
      message = exception.getResponse();
    } else {
      status = HttpStatus.CONFLICT;
    }

    if (exception.code === 'P2002') {
      status = HttpStatus.CONFLICT;
      message = 'Resource already exists';
    }

    // Development-only: log the stack trace for non-HttpExceptions
    if (process.env.NODE_ENV === 'development') {
      console.error(exception);
    }

    const responseBody = {
      success: false,
      statusCode: status,
      data: {
        timestamp: new Date().toISOString(),
        path: request.url,
        message: message['message'] || message,
      },
    };

    this.logger.error(
      `${request.method} ${request.url} ${status} - error: ${
        typeof message === 'object' ? message.message : message
      }`,
    );

    response.status(status).send(responseBody);
  }
}
