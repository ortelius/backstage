FROM nginx:mainline

RUN apt-get update && apt-get -y install jq && rm -rf /var/lib/apt/lists/*

RUN set -eu; \
  rm -rf /usr/share/nginx/html/*; \
  touch /usr/share/nginx/html/healthcheck;

COPY packages/app/dist /usr/share/nginx/html
COPY packages/app/docker/default.conf.template /etc/nginx/templates/default.conf.template

COPY packages/app/docker/inject-config.sh /docker-entrypoint.d/40-inject-config.sh

RUN set -eu; \
  chmod +x /docker-entrypoint.d/40-inject-config.sh

ENV PORT 80
