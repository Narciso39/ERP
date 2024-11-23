import { Injectable } from '@nestjs/common';
import { UserCreateDTO } from './dto/user-create.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class UserService {
    constructor(private readonly prisma: PrismaService) {}

    async store(newUser: UserCreateDTO) {
        return this.prisma.user.create({
            data: newUser
        });
    }
  
}
