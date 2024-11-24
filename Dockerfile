FROM node:latest

WORKDIR /usr/src/api

COPY . .

COPY ./.env.production ./.env

RUN npm install --quiet --no-optional --no-fund --loglevel=error

RUN npm run build

EXPOSE 3000

# Definir o comando para iniciar a aplicação
CMD ["npm", "run", "start:migrate:prod"]
