# Load Balancer

[![service.png](service.png)](service.png)

LoadBalancers are used to expose a service outside of a Kubernetes cluster.
These are often paired with an ingress controller to support HTTP routing.

```bash
readonly gok_server_ip=$(kubectl get svc gok-server-lb -o json | jq -r .status.loadBalancer.ingress[0].ip)
cat k8s/05-gok-client-lb/deployment.yaml | sed "s:gok-server-lb:${gok_server_ip}:g" | kubectl apply -f -
kubectl logs -f -l app=gok-client-lb
```
