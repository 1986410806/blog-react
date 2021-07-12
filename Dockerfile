FROM node:alpine as builder

WORKDIR /app

COPY package.json /app

RUN yarn config set registry https://registry.npm.taobao.org && \
  yarn --no-cache

COPY . .

RUN yarn build

FROM nginx:alpine

WORKDIR /var/nginx/html
COPY --from=builder /app/build/ .
COPY nginx.host.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
