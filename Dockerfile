FROM alpine:latest

LABEL maintainer="Martin Peters" \
      version="0.1" \
      description="Preconfigured Postfix Mail Relay"

ENV PF_HOSTNAME="" \
    PF_RELAY_HOST="" \
    PF_USERNAME="" \
    PF_PASSWORD="" \
    PF_ALLOWED_NETWORK=""

# install Postfix
RUN apk -U add postfix ca-certificates libsasl \
    && rm -rf /var/cache/apk/*

EXPOSE 25

ADD postfix-entrypoint.sh /usr/bin/postfix-entrypoint.sh

ENTRYPOINT [ "/usr/bin/postfix-entrypoint.sh" ]