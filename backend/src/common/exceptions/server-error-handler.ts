// import { Logger } from '@nestjs/common';
// import { NestFactory } from '@nestjs/core';
// import {
//   FastifyAdapter,
//   NestFastifyApplication,
// } from '@nestjs/platform-fastify';
// import * as process from 'process';
// import helmet from '@fastify/helmet';
// import { ConfigService } from '@nestjs/config';
// import { ValidationPipe, VersioningType } from '@nestjs/common';
// import { ExceptionsFilter } from './exceptions.filter';
// import { ResponseFormatInterceptor } from '../interceptors';
// import { LoggerMiddleware } from '../middlewares/logger.middleware';

// export class ServerErrorHandler {
//   private static readonly logger = new Logger('ServerErrorHandler');
//   private static restartAttempts = 0;
//   private static readonly MAX_RESTART_ATTEMPTS = 5;
//   private static readonly RESTART_DELAY = 5000;
//   private static app: NestFastifyApplication;
//   private static AppModule: any;

//   static async initialize(app: NestFastifyApplication, AppModule: any) {
//     this.app = app;
//     this.AppModule = AppModule;
//     this.setupErrorHandlers();
//   }

//   private static async restartServer() {
//     this.restartAttempts++;

//     if (this.restartAttempts > this.MAX_RESTART_ATTEMPTS) {
//       this.logger.error(
//         `Maximum restart attempts (${this.MAX_RESTART_ATTEMPTS}) reached. Shutting down.`,
//       );
//       process.exit(1);
//     }

//     this.logger.warn(
//       `Attempting to restart server (Attempt ${this.restartAttempts}/${this.MAX_RESTART_ATTEMPTS})`,
//     );

//     try {
//       if (this.app) {
//         await this.app.close();
//       }

//       await new Promise((resolve) => setTimeout(resolve, this.RESTART_DELAY));

//       // Recreate the application with all configurations
//       const app = await NestFactory.create<NestFastifyApplication>(
//         this.AppModule,
//         new FastifyAdapter(),
//       );

//       const configService = app.get(ConfigService);

//       // Reapply all your middleware and configurations
//       app.use(new LoggerMiddleware().use);

//       const fastifyInstance = app.getHttpAdapter().getInstance();
//       fastifyInstance
//         .addHook('onRequest', async (req, res) => {
//           req.socket['encrypted'] =
//             configService.getOrThrow<string>('NODE_ENV') === 'production';
//         })
//         .decorateReply('setHeader', function (name: string, value: unknown) {
//           this.header(name, value);
//         })
//         .decorateReply('end', function () {
//           this.send('');
//         });

//       app.useGlobalPipes(
//         new ValidationPipe({
//           transform: true,
//           whitelist: true,
//           forbidNonWhitelisted: true,
//           disableErrorMessages:
//             configService.getOrThrow<string>('NODE_ENV') === 'production'
//               ? true
//               : false,
//         }),
//       );

//       app.useGlobalFilters(new ExceptionsFilter());
//       app.useGlobalInterceptors(new ResponseFormatInterceptor());

//       await app.register(helmet, {
//         contentSecurityPolicy: false,
//       });

//       const globalPrefix = 'api';
//       app.setGlobalPrefix(globalPrefix);

//       app.enableCors();

//       app.enableVersioning({
//         type: VersioningType.URI,
//         prefix: 'v',
//       });

//       app.enableShutdownHooks();

//       const port: number = configService.get<number>('PORT') || 7000;
//       await app.listen(port, '0.0.0.0');

//       this.app = app;
//       this.logger.log('Server successfully restarted');
//       this.restartAttempts = 0;

//       this.logger.log(
//         `🚀 Using ${configService.getOrThrow<string>('NODE_ENV')} environment...`,
//       );
//       this.logger.log(
//         `🚀 Application is running on: ${await app.getUrl()}/${globalPrefix}`,
//       );
//       this.logger.log(
//         `🚀 Application is running on: ${await app.getUrl()}/${globalPrefix}/docs`,
//       );
//     } catch (error) {
//       this.logger.error('Failed to restart server:', error);
//       await this.restartServer();
//     }
//   }

//   private static setupErrorHandlers() {
//     process.on('uncaughtException', async (error) => {
//       this.logger.error('Uncaught Exception:', error);
//       await this.restartServer();
//     });

//     process.on('unhandledRejection', async (error: any, promise) => {
//       this.logger.error('Unhandled Rejection at:', error.stack);
//       this.logger.error('Error:', error);
//       await this.restartServer();
//     });

//     process.on('SIGTERM', async () => {
//       this.logger.warn('Received SIGTERM signal');
//       await this.gracefulShutdown();
//     });

//     process.on('SIGINT', async () => {
//       this.logger.warn('Received SIGINT signal');
//       await this.gracefulShutdown();
//     });
//   }

//   private static async gracefulShutdown() {
//     this.logger.log('Initiating graceful shutdown...');
//     try {
//       if (this.app) {
//         await this.app.close();
//       }
//       process.exit(0);
//     } catch (error) {
//       this.logger.error('Error during graceful shutdown:', error);
//       process.exit(1);
//     }
//   }
// }
