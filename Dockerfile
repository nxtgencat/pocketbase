FROM alpine:latest

ARG VERSION
ARG TARGETARCH
ARG TARGETVARIANT

RUN apk add --no-cache ca-certificates unzip curl

# Download PocketBase
RUN curl -fsSL "https://github.com/pocketbase/pocketbase/releases/download/v${VERSION}/pocketbase_${VERSION}_linux_${TARGETARCH}${TARGETVARIANT}.zip" -o /tmp/pb.zip && \
    unzip /tmp/pb.zip -d /pocketbase && rm /tmp/pb.zip

COPY entrypoint.sh /pocketbase/
RUN chmod +x /pocketbase

EXPOSE 8090
WORKDIR /pocketbase
ENTRYPOINT ["/pocketbase/entrypoint.sh"]
