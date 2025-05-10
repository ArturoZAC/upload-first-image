FROM node:22-alpine3.20

WORKDIR /app

COPY app.js package.json ./

RUN npm install

CMD ["node", "app.js"]