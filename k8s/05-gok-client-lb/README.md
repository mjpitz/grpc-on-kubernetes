# Load Balancer

[![service.png](service.png)](service.png)

LoadBalancers are used to expose a service outside of a Kubernetes cluster.
These are often paired with an ingress controller to support HTTP routing.

```bash
readonly gok_server_ip=$(kubectl get svc gok-server-lb -o json | jq -r .status.loadBalancer.ingress[0].ip)
cat k8s/05-gok-client-lb/deployment.yaml | sed "s:gok-server-lb:${gok_server_ip}:g" | kubectl apply -f -
kubectl logs -f -l app=gok-client-lb
```

* Sticky server behavior comes from kube-proxy being configured with iptables
  * This can be configured to use ipvs for load balancing support
  * For more details on this, see this [blog post](https://kubernetes.io/blog/2018/07/09/ipvs-based-in-cluster-load-balancing-deep-dive/) 
