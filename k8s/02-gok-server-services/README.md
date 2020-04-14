# Kubernetes Services

[Application services](https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/) are used to connect applications together in a Kubernetes environment.
Most, if not all of these mechanisms result in [DNS](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#services) records.

A `ClusterIP` service exposes a set of pods as a single virtual IP within the cluster.
This IP can be resolved from DNS using the service name. 

A `NodePort` node port service builds on the clusterIP service by adding node level port mappings, allowing the service to be addressed from outside the cluster.

Building on the `NodePort`, a `LoadBalancer` service provisions an external load balancer external to the cluster (typically provided by the cloud provider).
The load balancer is configured to round robin between the available nodes within the cluster. 

[Headless Services](https://kubernetes.io/docs/concepts/services-networking/service/#headless-services) strip services of a clusterIP and expose pod IPs directly to their clients.
These are commonly used with stateful services where it's possible to obtain more stable addressing schemes.
Headless services can expose both `A` and `SRV` records over DNS.

Finally, an `ExternalName` can be used to create a reference to a service outside the cluster.
This can easily be thought of as a way to provide `CNAME` records to DNS. 

```bash
kubectl apply -f k8s/02-gok-server-services/
```
