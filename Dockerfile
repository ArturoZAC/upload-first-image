FROM node:22-alpine3.20 AS deps
WORKDIR /app
COPY package.json ./
RUN npm install

FROM node:22-alpine3.20 AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run test


FROM node:22-alpine3.20 AS prod-deps
WORKDIR /app
COPY package.json ./
RUN npm install --prod


FROM node:22-alpine3.20 AS runner
WORKDIR /app
COPY --from=prod-deps /app/node_modules ./node_modules
COPY app.js ./
COPY tasks/ ./tasks
CMD ["node", "app.js"]