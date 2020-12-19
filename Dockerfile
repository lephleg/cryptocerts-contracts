# pull official base image
FROM node:14.15.2-alpine

WORKDIR /dapp

RUN npm install -g truffle --silent

EXPOSE 8080
ENTRYPOINT []