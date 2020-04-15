#!/usr/bin/env bash

## TMUX panes:
##   1. watch kubectl get pods,svc
##   2. client logs
##   3. apply / delete / etc

kubectl config set-context $(kubectl config current-context) --namespace grpc
watch kubectl get pods,svc

## Apply init and briefly describe namespaces.

kubectl apply -f k8s/00-init/

## Walk through deployment configuration (replicas, liveness, readiness)
## Apply and watch the rollout
## Demonstrate scaling up clusters and watching rollout

kubectl apply -f k8s/01-gok-server-deployment/
kubectl rollout status deployment/gok-server -w
kubectl scale deployment/gok-server --replicas=3
kubectl rollout status deployment/gok-server -w

## Configure cluster services now
## Don't walk through in depth, each will get their own time

kubectl apply -f k8s/02-gok-server-services/

## Apply configuration
## Walk through cluster ip service (see README)
## Tail logs
## delete backend to demonstrate failover
## (repeat)

kubectl apply -f k8s/03-gok-client-clusterip/
kubectl logs -f -l app=gok-client-clusterip
kubectl delete pod $(kubectl logs --tail 1 -l app=gok-client-clusterip | awk '{print $6}')

## Apply configuration
## Walk through headless service (see README)
## Tail logs
## Scale down
## Scale up

kubectl apply -f k8s/04-gok-client-headless/
kubectl logs -f -l app=gok-client-headless
kubectl scale deployment/gok-server --replicas=2
kubectl scale deployment/gok-server --replicas=4

## Walk through load balancer service (see README)
## Demonstrate obtaining load balancer ip
## Apply updated configuration for load balancer
## Tail logs

readonly gok_server_ip=$(kubectl get svc gok-server-lb -o json | jq -r .status.loadBalancer.ingress[0].ip)
cat k8s/05-gok-client-lb/deployment.yaml | sed "s:gok-server-lb:${gok_server_ip}:g" | kubectl apply -f -
kubectl logs -f -l app=gok-client-lb
kubectl delete pod $(kubectl logs --tail 1 -l app=gok-client-lb | awk '{print $6}')
