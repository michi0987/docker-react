FROM node:16-alpine as builder

USER node

RUN mkdir -p /home/node
WORKDIR /home/node

COPY --chown=node:node ./package.json .
RUN npm install

COPY --chown=node:node . .
RUN npm run build

FROM nginx
COPY --from=builder /home/node/build /usr/share/nginx/html