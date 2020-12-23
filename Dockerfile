FROM alpine:latest 
RUN apk add --no-cache tzdata
ENV TZ Asia/Taipei

RUN GRPC_HEALTH_PROBE_VERSION=v0.3.1 && \
    wget -qO/bin/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 && \
    chmod +x /bin/grpc_health_probe

EXPOSE 5000

COPY api /api

WORKDIR /
ENTRYPOINT ["./api"]
CMD  ["version"]



