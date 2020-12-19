# pull official base image
FROM node:14.15.2-alpine

WORKDIR /dapp

RUN npm install -g truffle --unsafe-perm=true --allow-root --silent

EXPOSE 8080
ENTRYPOINT []