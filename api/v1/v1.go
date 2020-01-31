package v1

//go:generate protoc -I=. -I=$GOPATH/src --gogo_out=plugins=grpc:$GOPATH/src v1.proto
