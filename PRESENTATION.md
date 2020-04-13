1. API Definition
   1. [Code Reference](api/v1/v1.proto)
   1. Resources
      * [Protocol Buffers](https://developers.google.com/protocol-buffers)
1. Code Generation
   1. [Code Reference](api/v1/v1.go)
1. gRPC Server
   1. [Code Reference](internal/server/command.go)
   1. Health API
   1. Resources
      * [Health example](https://github.com/grpc/grpc-go/tree/master/examples/features/health)
1. gRPC Client
   1. [Code Reference](internal/client/command.go)
   1. Load Balancing Policy
   1. Health API
   1. Resources
      * [Load balancing example](https://github.com/grpc/grpc-go/tree/master/examples/features/load_balancing)
      * [Health example](https://github.com/grpc/grpc-go/tree/master/examples/features/health)
1. Dockerfile
   1. [Code Reference](Dockerfile)
   1. Resources
      * [grpc-health-probe](https://github.com/grpc-ecosystem/grpc-health-probe)
1. Kubernetes Deployments
   1. [StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)
   1. [DaemonSets](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)
   1. [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
1. Deployment Configuration
   1. [Code Reference](k8s/01-gok-server-deployment)
   1. Replicas
   1. Liveness Probes
   1. Readiness Probes
   1. Resources
      * [Startup Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
1. Kubernetes Services
   1. [Code Reference](k8s/02-gok-server-services)
   1. ClusterIP
   1. NodePort
   1. LoadBalancer
   1. Headless
      1. A Records
      1. SRV Records
   1. ExternalName
      1. CNAME records
   1. Resources
      * [Application Services](https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/)
      * [Headless Services](https://kubernetes.io/docs/concepts/services-networking/service/#headless-services)
      * [DNS](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#services)
1. gRPC Targets
   1. `[resolver]://[resolver-address:resolver-port]/[service-name][:service-port]`
   1. Resources
      * [gRPC Name Resolution](https://github.com/grpc/grpc/blob/master/doc/naming.md)
      * [grpc-go DNS](https://github.com/grpc/grpc-go/blob/master/internal/resolver/dns/dns_resolver.go)
1. Clients in action
   1. cluster-ip client
      * [Code Reference](k8s/03-gok-client-clusterip)
   1. headless client
      * [Code Reference](k8s/04-gok-client-headless)
   1. load balancer client
      * [Code Reference](k8s/05-gok-client-lb)
