package client

import (
	"context"
	"fmt"
	"log"
	"time"

	"github.com/mjpitz/grpc-on-kubernetes/api/v1"

	"github.com/spf13/cobra"

	"google.golang.org/grpc"
)

var (
	target = ""

	Command = &cobra.Command{
		Use: "client",
		Short: "Start a client process",
		RunE: func(cmd *cobra.Command, args []string) error {
			cc, err := grpc.Dial(target, grpc.WithInsecure())
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
