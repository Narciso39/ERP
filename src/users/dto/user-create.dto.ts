import {
  IsEmail,
  IsIn,
  IsNotEmpty,
  IsString,
  IsStrongPassword,
  MaxLength,
} from 'class-validator';
import { UserRoles } from '../types/UserRoles';

export class UserCreateDTO {

// nome de usuário 
  @IsString()
  @IsNotEmpty()
  @MaxLength(100)
  username: string;

// email do usuário
  @IsEmail()
  @IsNotEmpty()
  @MaxLength(100)
  email: string;

// senha do usuário
  @IsString()
  @IsStrongPassword({
    minLength: 8,
    minLowercase: 1,
    minNumbers: 2,
    minSymbols: 1,
    minUppercase: 1,
  })
  password: string;

// permissões do usuário

  @IsIn(['admin', 'superuser', 'user'])
  roles: UserRoles;
}
