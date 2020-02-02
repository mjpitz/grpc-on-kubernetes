package main

import (
	"os"

	"github.com/mjpitz/grpc-on-kubernetes/internal/client"
	"github.com/mjpitz/grpc-on-kubernetes/internal/server"

	"github.com/spf13/cobra"
)

func main() {
	command := &cobra.Command{
		Use: "gok",
	}

	command.AddCommand(client.Command)
	command.AddCommand(server.Command)

	if err := command.Execute(); err != nil {
		os.Exit(1)
	}
}
