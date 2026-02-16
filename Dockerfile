FROM node:18-alpine

# Install build tools required for sqlite3
RUN apk add --no-cache python3 make g++

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --omit=dev

COPY . .

EXPOSE 3000

CMD ["node", "src/index.js"]

