package v1

// This is using the go generate ./... syntax but this protoc target could be invoked directly.
// For help getting started with protoc and a specific language, see their tutorials documentation.
// https://developers.google.com/protocol-buffers/docs/tutorials

//go:generate protoc -I=. -I=$GOPATH/src --gogo_out=plugins=grpc:$GOPATH/src v1.proto
