FROM node:18-alpine as builder

WORKDIR /app

ENV NODE_OPTIONS=--openssl-legacy-provider

COPY . .

RUN rm -rf node_modules

RUN apk update

RUN yarn add sharp

RUN yarn global add gatsby-cli

RUN yarn install --ignore-platform

FROM nginx

EXPOSE 80 

COPY --from=builder /app/public /usr/share/nginx/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]