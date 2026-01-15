# Dockerfile
FROM golang:alpine AS builder

RUN apk add --no-cache git

WORKDIR /app

# install xcaddy
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

# build
RUN xcaddy build --with github.com/caddy-dns/cloudflare \
                  --with github.com/caddy-dns/alidns

FROM caddy:latest
COPY --from=builder /app/caddy /usr/bin/caddy
