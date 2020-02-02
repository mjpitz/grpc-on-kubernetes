FROM golang:1.13-alpine AS builder

RUN GRPC_HEALTH_PROBE_VERSION=v0.3.1 && \
    GOOS=$(go env GOOS) && \
    GOARCH=$(go env GOARCH) && \
    wget -qO/go/bin/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-${GOOS}-${GOARCH} && \
    chmod +x /go/bin/grpc_health_probe

RUN apk update && apk add --no-cache git ca-certificates && update-ca-certificates

ENV CGO_ENABLED=0

WORKDIR $GOPATH/src/github.com/mjpitz/grpc-on-kubernetes
COPY . .

RUN go mod download

RUN go build -a \
  -ldflags='-w -s -extldflags "-static"' \
  -o /go/bin/gok \
  .

FROM scratch

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

COPY --from=builder /go/bin/grpc_health_probe /usr/bin/grpc_health_probe
COPY --from=builder /go/bin/gok /usr/bin/gok

USER 10001:10001

ENTRYPOINT [ "/usr/bin/gok" ]
