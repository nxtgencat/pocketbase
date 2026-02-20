FROM alpine:latest AS download
ARG VERSION TARGETARCH TARGETVARIANT
RUN apk add --no-cache curl unzip \
    && curl -fsSL "https://github.com/pocketbase/pocketbase/releases/download/v${VERSION}/pocketbase_${VERSION}_linux_${TARGETARCH}${TARGETVARIANT}.zip" -o /tmp/pb.zip \
    && unzip /tmp/pb.zip -d /tmp/pb

FROM alpine:latest
RUN apk add --no-cache ca-certificates curl
COPY --from=download /tmp/pb/pocketbase /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
EXPOSE 8090
ENTRYPOINT ["entrypoint.sh"]
