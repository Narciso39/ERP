import { Body, Controller, Get, Post } from '@nestjs/common';
import { UserService } from './user.service';
import { UserCreateDTO } from './dto/user-create.dto';

@Controller('user')
export class UserController {
  constructor(private readonly UserService: UserService) {}
  @Post()
  async create(@Body() user: UserCreateDTO) {
    return this.UserService.store(user);
  }
}
