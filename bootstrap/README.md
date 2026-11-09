# Bootstrap

Everything needed to take freshly installed Talos nodes to a cluster that Flux
manages on its own. The entire process is driven by a single command:

```sh
mise run //bootstrap:cluster
```

Once it completes, Flux reconciles the rest of the repository and this
directory is not used again until the next rebuild.

## Prerequisites

- mise, talosctl, minijinja-cli, op, yq, jq, kubectl, helmfile, kustomize and
  gum on the PATH.
- A signed-in 1Password CLI (`op`). Machine secrets never live in this repo; every
  `op://` reference in the Talos configs and bootstrap manifests is resolved
  at apply time with `op inject`.
- A valid `talosconfig` at the repo root (mise points `TALOSCONFIG` there).
  The bootstrap tasks derive the controller endpoint and node list from
  `talosctl config info`, so nothing is hardcoded here.
- Working BGP between the cluster and the UniFi gateway. `k8s.internal` points
  at the Cilium LoadBalancer VIP, which exists only once Cilium is installed, so
  bootstrap talks to the controller's node IP directly until the `apps` stage
  brings Cilium up. See
  [networking.yaml](../kubernetes/apps/kube-system/cilium/app/networking.yaml)
  for the BGP peer, the `kube-api` Service and the
  `192.168.69.0/24` LoadBalancer pool.

## Stages

`mise run //bootstrap:cluster` runs these stages in order (see [mise.toml](mise.toml)):

```mermaid
graph LR
    nodes --> k8s --> kubeconfig --> base --> apps
```

1. **nodes** - Renders each node's Talos config (`talos/*.j2` templates plus
   1Password injection) and applies it with `talosctl apply-config --insecure`.
   Nodes that are already configured are skipped, so the stage is idempotent.
2. **k8s** - Runs `talosctl bootstrap` against the controller, retrying until
   etcd reports the cluster already exists.
3. **kubeconfig** - Fetches the kubeconfig with `talosctl kubeconfig`, then
   rewrites the server address to the controller's node IP: the generated
   `https://k8s.internal:6443` points at the Cilium VIP, which does not
   exist yet. The final stage re-fetches the kubeconfig so the endpoint
   returns to `k8s.internal` once Cilium is serving it.
4. **base** - Waits for every control plane apiserver to answer `/readyz`
   and for nodes to register (they stay `Ready=False` until the CNI is
   installed), then applies:
    - `kustomize/` - bootstrap Secrets rendered through `op inject`, plus
      their namespaces: 1Password Connect credentials and token plus the
      Cloudflare tunnel ID (`personal/`). These exist before their
      controllers so nothing deadlocks on a missing Secret.
    - `helmfile/crds.yaml` - CRDs extracted from upstream charts and applied
      directly. Installing CRDs out-of-band means Flux Kustomizations that
      consume CRD-backed resources don't need `dependsOn` chains.
5. **apps** - `helmfile sync` of `helmfile/apps.yaml`, the minimal release
   chain Flux needs before it can take over:

    cilium → coredns → spegel → cert-manager → external-secrets →
    onepassword-connect → flux-operator → flux-instance

    Once `flux-instance` is healthy, Flux reconciles `kubernetes/` and manages
    these same releases from then on.

> [!TIP]
> Every stage is safe to re-run. If bootstrap fails partway, fix the issue
> and run `mise run //bootstrap:cluster` again.

## Data restore (Kopiur)

Bootstrap itself restores no application data; that happens declaratively
once Flux takes over, via [Kopiur](https://github.com/home-operations/kopiur)
(deployed from [kubernetes/apps/kopiur-system/](../kubernetes/apps/kopiur-system/)).

Apps that opt into the `kopiur/backup` component get a PVC whose
`spec.dataSourceRef` points at a Kopiur `Restore` with `target.populator: {}`
(see [kubernetes/components/kopiur/backup/](../kubernetes/components/kopiur/backup/)).
That makes the `Restore` a
passive volume-populator source: when Flux applies the app on a fresh
cluster, the PVC is provisioned by restoring the latest snapshot for the
app's SnapshotPolicy from the repository. The PVC stays unbound while the
restore mover Job runs, so the app's pod simply stays `Pending` until the
data is back; no ordering logic needed anywhere.

Because the `Restore`s use `onMissingSnapshot: Continue`, an app with no
snapshot yet (a brand-new app, or a deliberately fresh start) comes up with
an empty volume instead of failing; the same manifests handle first deploy
and disaster recovery ("deploy-or-restore").

Each `Restore` pins the snapshot it resolved on first reconciliation and
never silently retargets, even if a schedule fires mid-restore. Expect pods
to sit `Pending` for as long as their volume takes to restore.

## Single source of truth

The helmfiles define no chart versions or values of their own. Each release's
chart and version are read from the app's `ocirepository.yaml` and its values
from the app's `helmrelease.yaml` under `kubernetes/apps/` (see
[helmfile/templates/](helmfile/templates/)). Bootstrap therefore installs
exactly what Flux will later reconcile, and Renovate updates only one place.
