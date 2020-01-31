FROM golang:1.13-alpine AS builder

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

COPY --from=builder /go/bin/gok /usr/bin/gok

USER 10001:10001

ENTRYPOINT [ "/usr/bin/gok" ]
