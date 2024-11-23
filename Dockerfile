# Etapa de construção
FROM node:alpine AS builder

WORKDIR /usr/src/api

# Copiar o package.json primeiro para garantir que o npm install funcione
COPY package*.json ./
COPY prisma ./prisma/

# Instalar as dependências
RUN npm install --quiet --no-optional --no-fund --loglevel=error

# Copiar o restante dos arquivos depois de instalar as dependências
COPY . ./
COPY ./.env.production ./.env

# Rodar o build da aplicação
RUN npm run build

# Etapa final
FROM node:alpine

# Copiar os arquivos necessários do container de construção para o container final
# COPY --from=builder /usr/src/api/node_modules ./node_modules
# COPY --from=builder /usr/src/api/package*.json ./package*.json
# COPY --from=builder /usr/src/api/dist ./dist
# COPY --from=builder /usr/src/api/prisma ./prisma

# Caso precise do wait-for-it.sh, descomente as linhas abaixo
# COPY ./wait-for-it.sh /usr/src/api/wait-for-it.sh
# RUN chmod +x /usr/src/api/wait-for-it.sh

EXPOSE 3000

# Definir o comando para rodar a aplicação
CMD [ "npm", "run", "start:migrate:prod" ]
