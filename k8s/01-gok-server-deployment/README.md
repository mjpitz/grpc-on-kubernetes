# Deployments

Kubernetes workloads come in many different shapes and forms.

* [Pods](https://kubernetes.io/docs/concepts/workloads/pods/pod/)
  * They are the smallest unit of execution, encompassing a collection of containers.
  * Often not used directly.
* [CronJob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)
  * Used to run scheduled, batch style workloads.
* [StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)
  * Used to manage stateful workloads with backing persistent data.
  * Examples: MySQL, ZooKeeper, Redis, etc
* [DaemonSets](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)
  * Used to manage node agents deployed to the cluster.
  * Examples: DataDog, Consul, Prometheus Node Exporter, etc
* [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
  * Generic deployment mechanism used to manage scalable workloads.
  * Examples: Your every day stateless service

In this project, we only need to concern ourself with Deployments.

```bash
kubectl apply -f k8s/01-gok-server-deployment/
kubectl rollout status deployment/gok-server -w
kubectl scale deployment/gok-server --replicas=3
kubectl rollout status deployment/gok-server -w
```
