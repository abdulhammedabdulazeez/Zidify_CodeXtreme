import { NestFactory } from '@nestjs/core';
import {
  FastifyAdapter,
  NestFastifyApplication,
} from '@nestjs/platform-fastify';
import helmet from '@fastify/helmet';
import { AppModule } from './app.module';
import { ConfigService } from '@nestjs/config';
import { Logger, ValidationPipe, VersioningType } from '@nestjs/common';
import { LoggerMiddleware } from './common/middlewares/logger.middleware';
import { ResponseFormatInterceptor } from './common/interceptors/response.interceptor';
import { ExceptionsFilter } from './common/exceptions';

async function bootstrap() {
  //@ts-ignore
  const app = await NestFactory.create<NestFastifyApplication>(
    AppModule,
    new FastifyAdapter(),
  );

  const configService: ConfigService = await app.get(ConfigService);

  app.use(new LoggerMiddleware().use);

  const fastifyInstance = app.getHttpAdapter().getInstance();
  fastifyInstance
    .addHook('onRequest', async (req) => {
      req.socket['encrypted'] =
        configService.getOrThrow<string>('NODE_ENV') === 'production';
    })
    .decorateReply('setHeader', function (name: string, value: unknown) {
      this.header(name, value);
    })
    .decorateReply('end', function () {
      this.send('');
    });

  app.useGlobalPipes(
    new ValidationPipe({
      transform: true,
      whitelist: true,
      forbidNonWhitelisted: true,
      disableErrorMessages:
        configService.getOrThrow<string>('NODE_ENV') === 'production'
          ? true
          : false,
    }),
  );

  // await ServerErrorHandler.initialize(app, AppModule);
  app.useGlobalFilters(new ExceptionsFilter());
  app.useGlobalInterceptors(new ResponseFormatInterceptor());

  app.register(helmet, {
    contentSecurityPolicy: false,
  });

  const globalPrefix = 'api';
  app.setGlobalPrefix(globalPrefix);

  app.enableCors();

  app.enableVersioning({
    type: VersioningType.URI,
    prefix: 'v',
  });

  // Handle shutdown gracefully
  app.enableShutdownHooks();

  const port: number = configService.get<number>('PORT') || 3000;
  await app.listen(port, '0.0.0.0');

  Logger.log(
    `🚀 Using ${configService.getOrThrow<string>('NODE_ENV')} environment...`,
  );
  Logger.log(
    `🚀 Application is running on: ${await app.getUrl()}/${globalPrefix}`,
  );
  Logger.log(
    `🚀 Application is running on: ${await app.getUrl()}/${globalPrefix}/docs`,
  );
}

bootstrap();
