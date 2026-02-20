# --- Build stage: download and extract PocketBase ---
FROM alpine:latest AS downloader

ARG VERSION
ARG TARGETARCH
ARG TARGETVARIANT

RUN apk add --no-cache curl unzip \
    && curl -fsSL "https://github.com/pocketbase/pocketbase/releases/download/v${VERSION}/pocketbase_${VERSION}_linux_${TARGETARCH}${TARGETVARIANT}.zip" -o /tmp/pb.zip \
    && unzip /tmp/pb.zip -d /tmp/pb

# --- Final stage: minimal runtime image ---
FROM alpine:latest

RUN apk add --no-cache ca-certificates

COPY --from=downloader /tmp/pb/pocketbase /usr/local/bin/pocketbase
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 8090
WORKDIR /pocketbase

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s \
    CMD wget -qO- http://localhost:8090/api/health || exit 1

ENTRYPOINT ["entrypoint.sh"]
