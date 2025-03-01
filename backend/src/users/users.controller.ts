import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { UsersService } from './users.service';
import { CreateUserDto } from './dtos/create-user.dto';
import { UpdateUserDto } from './dtos/update-user.dto';
import {
  CurrentUser,
  RequireAbilities,
  RequireUserAbilities,
} from 'src/common/decorators';
import { User as IUser } from '@prisma/client';
import {
  Action,
  Subjects,
  CaslAbilityFactory,
} from 'src/casl/casl-ability.factory/casl-ability.factory';
import { User } from './entities/user.entity';

@Controller('users')
export class UsersController {
  constructor(
    private readonly usersService: UsersService,
    private caslAbilityFactory: CaslAbilityFactory,
  ) {}

  @Post()
  create(@Body() createUserDto: CreateUserDto) {
    return this.usersService.create(createUserDto);
  }

  @Get('me')
  @RequireUserAbilities({ action: Action.Read, subject: User })
  findMe(@CurrentUser('id') userId: string) {
    return this.usersService.findMe(userId);
  }

  @Get('savebox')
  getSavebox(@CurrentUser('id') userId: string) {
    return this.usersService.getSavebox(userId);
  }

  @Get()
  findAll() {
    return this.usersService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.usersService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateUserDto: UpdateUserDto) {
    return this.usersService.update(id, updateUserDto);
  }

  @Delete('delete')
  remove(@CurrentUser() user: IUser) {
    return this.usersService.remove(user);
  }
}
