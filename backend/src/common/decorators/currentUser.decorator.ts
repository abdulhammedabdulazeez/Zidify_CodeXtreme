import {
  createParamDecorator,
  ExecutionContext,
  NotFoundException,
} from '@nestjs/common';
import { JwtUser } from '../types/jwtUser.type';

export const CurrentUser = createParamDecorator(
  (data: keyof JwtUser | undefined, context: ExecutionContext) => {
    const ctx = context.switchToHttp();
    const request = ctx.getRequest();

    if (!request.user) {
      throw new NotFoundException('User not found!');
    }

    const user = request.user as JwtUser;

    if (data) {
      return user[data] as string;
    }

    return user;
  },
);
