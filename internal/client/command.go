package client

import (
	"context"
	"fmt"
	"log"
	"time"

	"github.com/mjpitz/grpc-on-kubernetes/api/v1"

	"github.com/spf13/cobra"

	"google.golang.org/grpc"
	// The health package must be imported in order to initialize the client side check function.
	// Otherwise, clients won't be able to leverage the health service to inspect a back ends health.
	_ "google.golang.org/grpc/health"
)

// Service config allows owners to publish parameters to be automatically
// used by all clients.
// https://github.com/grpc/grpc/blob/master/doc/service_config.md

// This includes a healthCheckConfig that enables transparently inspecting
// upstream backend instances before routing requests to them.
// https://github.com/grpc/grpc-go/tree/master/examples/features/health

// By default, loadBalancingPolicy uses a "pick_first" strategy.

const serviceConfig = `{
	"loadBalancingPolicy": "round_robin",
	"healthCheckConfig": {
		"serviceName": ""
	}
}`

var (
	target = ""

	Command = &cobra.Command{
		Use:   "client",
		Short: "Start a client process",
		RunE: func(cmd *cobra.Command, args []string) error {
			// Dialing insecurely (e.g. plaintext)
			// Using the provided service config
			cc, err := grpc.Dial(target,
				grpc.WithInsecure(),
				grpc.WithDefaultServiceConfig(serviceConfig))

			if err != nil {
				return err
			}

			client := v1.NewDemoClient(cc)

			for {
				time.Sleep(time.Second)

				response, err := client.Echo(context.Background(), &v1.EchoRequest{})

				var message string

				if err != nil {
					message = fmt.Sprintf("[error] %s", err.Error())
				} else {
					message = fmt.Sprintf("[info] hello from %s", response.GetHostname())
				}

				log.Println(message)
			}
		},
	}
)

func init() {
	flags := Command.Flags()

	flags.StringVarP(&target, "target", "t", target, "the address of the grpc server")
}
