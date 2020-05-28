# Derived from https://docs-develop.pleroma.social/backend/installation/alpine_linux_en/

FROM alpine:latest

WORKDIR /

RUN awk 'NR==2' /etc/apk/repositories | sed 's/main/community/' | tee -a /etc/apk/repositories

RUN apk update && apk upgrade

# TODO: Do I need --virtual .*?
RUN apk add --no-cache --virtual .build-base build-base \
    && apk add --no-cache --virtual .certbot certbot \
    && apk add --no-cache --virtual .elixir elixir \
    && apk add --no-cache --virtual .erlang erlang erlang-eldap erlang-parsetools erlang-runtime-tools erlang-xmerl \
    && apk add --no-cache --virtual .git git \
    && apk add --no-cache --virtual .nginx nginx \
    && apk add --no-cache --virtual .postgresql postgresql postgresql-contrib

RUN /etc/init.d/postgresql start && rc-update add postgresql

RUN addgroup pleroma && adduser -S -s /bin/false -h /opt/pleroma -H -G pleroma pleroma

RUN mkdir -p /opt/pleroma && chown -R pleroma:pleroma /opt/pleroma

# Use pleroma stable branch
#RUN su -l pleroma -s $SHELL -c 'git clone -b stable https://git.pleroma.social/pleroma/pleroma /opt/pleroma'

# Use my pleroma
COPY ./pleroma/ /opt/pleroma

WORKDIR /opt/pleroma

# TODO: Answer yes to install hex.
RUN su -l pleroma -s $SHELL -c 'mix deps.get'

# TODO: Answer yes to install rebar3.
RUN su -l pleroma -s $SHELL -c 'mix pleroma.instance gen'

# TODO: Answer questions.

RUN mv config/{generated_config.exs,prod.secret.exs}

RUN su -l postgresql -s $SHELL -c 'psql -f config/setup_db.psql'

RUN su -l pleroma -s $SHELL -c 'MIX_ENV=prod mix ecto.migrate' && su -l pleroma -s $SHELL -c 'MIX_ENV=prod mix phx.server'

# TODO: Validate this (might need to stop nginx before this if installation auto-starts it).
RUN mkdir -p /var/lib/letsencrypt/ \
    && certbot certonly --email schwarmau@gmail.com -d cyborg.cafe --standalone \
    && cp /opt/pleroma/installation/pleroma.nginx /etc/nginx/conf.d/pleroma.conf

# NOTE: To renew certificate, uncomment relevant block in nginx config and run `certbot certonly --email <email> -d <domain> --webroot -w /var/lib/letsencrypt/

# TODO: Modify nginx config (see https://docs-develop.pleroma.social/backend/installation/alpine_linux_en/#nginx).
#       I Think the best way to do this is to store the config file externally and copy it in.

RUN rc-update add nginx && service nginx start

RUN cp /opt/pleroma/installation/init.d/pleroma /etc/init.d/pleroma && rc-update add pleroma

RUN su -l pleroma -s $SHELL -c 'MIX_ENV=prod mix pleroma.user new admin schwarmau@gmail.com --admin'