# grpc-on-kubernetes

[https://github.com/mjpitz/grpc-on-kubernetes](https://github.com/mjpitz/grpc-on-kubernetes)

This repository contains materials that I plan on using for my 2020 conference presentations.
The goal of the talk is to demonstrate how to run gRPC clients and servers on Kubernetes.
We will walk through a variety of deployment configurations.
Each will demonstrate both simple and complex use cases.

## Using a kind server

```bash
$ KUBECONFIG=~/.kube/grpc.yaml kind create cluster
$ kubectl config use-context kind-kind
$ kubectl apply -f k8s/00-init/
$ kubectl config set-context kind-kind --namespace grpc
```

Once the context is configured, you can apply the configuration used for the demonstration.

```bash
$ kubectl apply -f k8s/01-gok-server-deployment/
$ kubectl apply -f k8s/02-gok-server-services/
$ kubectl apply -f k8s/03-gok-client-clusterip/
$ kubectl apply -f k8s/04-gok-client-headless/
```

## Presentation Outline

* See [PRESENTATION.md](PRESENTATION.md) for a complete overview of the presentation.
* See [present.sh](present.sh) for all shell commands that are used during this project.

## Connect with me

* [Twitter](https://twitter.com/_mjpitz_)
* [GitHub](https://github.com/mjpitz)
* [LinkedIn](https://www.linkedin.com/in/mjpitz/)
