FROM node:9.4.0-alpine

WORKDIR /usr/src/app
COPY package*.json ./

ENV NODE_ENV prod
LABEL VERSION=$VERSION 
   
RUN npm install

COPY . .

EXPOSE 3000

CMD [ "npm", "start" ]