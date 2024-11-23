FROM node:alpine AS builder

WORKDIR /usr/src/api

COPY package*.json ./
COPY prisma ./prisma/
RUN npm install --quiet --no-optional --no-fund --loglevel=error
COPY . ./
COPY ./.env.production ./.env
COPY ./wait-for-it.sh /usr/src/api/wait-for-it.sh

RUN chmod +x /usr/src/api/wait-for-it.sh

RUN npm run build

FROM node:alpine

COPY --from=builder /usr/src/api/node_modules ./node_modules
COPY --from=builder /usr/src/api/package*.json ./package*.json
COPY --from=builder /usr/src/api/dist ./dist
COPY --from=builder /usr/src/api/prisma ./prisma
COPY --from=builder /usr/src/api/wait-for-it.sh /usr/src/api/wait-for-it.sh

EXPOSE 3000

CMD ["./wait-for-it.sh", "db", "5432", "--", "npm", "run", "start:migrate:prod"]
