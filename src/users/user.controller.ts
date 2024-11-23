import { Controller, Get } from '@nestjs/common';

@Controller()
export class UserController {
  @Get()
  getHello(): string {
    return String(process.env.NODE_ENV);
  }
}