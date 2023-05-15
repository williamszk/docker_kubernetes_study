FROM node:16-alpine AS builder

USER node
RUN mkdir /home/node/app
WORKDIR /home/node/app

COPY --chown=node:node ./package.json ./
RUN npm install

COPY --chown=node:node ./ ./

RUN npm run build
# /home/node/app/build <-- all the stuff we care about

FROM nginx
COPY --from=builder /home/node/app/build /usr/share/nginx/html

