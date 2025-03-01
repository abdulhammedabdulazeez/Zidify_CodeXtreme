import {
  ExecutionContext,
  Injectable,
  Logger,
  UnauthorizedException,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { AuthGuard as PassportAuthGuard } from '@nestjs/passport';

@Injectable()
export class JwtGuard extends PassportAuthGuard('jwt') {
  private readonly logger = new Logger(JwtGuard.name);
  constructor(private readonly reflector: Reflector) {
    super();
  }

  getRequest(context: ExecutionContext) {
    const ctx = context.switchToHttp();
    const request = ctx.getRequest();
    return request;
  }

  canActivate(context: ExecutionContext): boolean | Promise<boolean> {
    const isPublic = this.reflector.getAllAndOverride<boolean>('isPublic', [
      context.getHandler(),
      context.getClass(),
    ]);
    if (isPublic) return true;

    return super.canActivate(context) as boolean;
  }

  handleRequest(err: any, user: any, info: any) {
    if (err || !user) {
      const message = err?.message ?? info.message;
      this.logger.error('Unauthorized request', info);
      throw new UnauthorizedException(message);
    }
    return user;
  }
}
