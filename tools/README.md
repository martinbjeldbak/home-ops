## test-pod-ephemeral

Used to debug volumes and migrate files into to them from my NAS.

Deploy it into the `default` namespace with

```sh
kubectl scale deployment radarr --replicas=0
kubectl apply -f test-pod-ephemeral.yaml
```

Copy files into the volume and then scale deployment back up.

