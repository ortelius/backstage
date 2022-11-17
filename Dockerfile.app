FROM nginx:mainline

LABEL org.opencontainers.image.source=https://github.com/ortelius/backstage/packages/app
LABEL org.opencontainers.image.description="Ortelius Backstage Frontend"

RUN apt-get update && apt-get -y install jq && rm -rf /var/lib/apt/lists/*

RUN set -eu; \
  rm -rf /usr/share/nginx/html/*; \
  touch /usr/share/nginx/html/healthcheck;

COPY packages/app/dist /usr/share/nginx/html
COPY packages/app/docker/default.conf.template /etc/nginx/templates/default.conf.template

COPY packages/app/docker/inject-config.sh /docker-entrypoint.d/40-inject-config.sh

RUN set -eu; \
  chmod +x /docker-entrypoint.d/40-inject-config.sh

ENV NODE_ENV production

ENV PORT 80

# stage1 - build react app first
# FROM node:19-alpine3.15 as build

# LABEL org.opencontainers.image.source=https://github.com/ortelius/backstage/packages/app
# LABEL org.opencontainers.image.description="Ortelius Backstage Frontend"

# WORKDIR /app

# ARG NPM_TOKEN
# ENV PATH /app/node_modules/.bin:$PATH

# COPY ./package.json /app/

# COPY . /app
# RUN ls

# RUN yarn install --immutable --immutable-cache --check-cache
# RUN yarn tsc
# RUN yarn lint:all
# RUN yarn test:all
# RUN yarn build

# EXPOSE 80

# # stage 2 - build the final image and copy the react build files
# FROM nginx:1.23.2-alpine as final
# COPY --from=build /app/build /usr/share/nginx/html
# RUN rm /etc/nginx/conf.d/default.conf
# COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]
