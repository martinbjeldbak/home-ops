<div align="center">

### My Homelab :anchor:

</div>

<div align="center">

[![Talos](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.martinbjeldbak.com%2Ftalos_version&style=for-the-badge&logo=talos&logoColor=white&color=blue&label=%20)](https://talos.dev)&nbsp;&nbsp;
[![Kubernetes](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.martinbjeldbak.com%2Fkubernetes_version&style=for-the-badge&logo=kubernetes&logoColor=white&color=blue&label=%20)](https://kubernetes.io)&nbsp;&nbsp;
[![Flux](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.martinbjeldbak.com%2Fflux_version&style=for-the-badge&logo=flux&logoColor=white&color=blue&label=%20)](https://fluxcd.io)&nbsp;&nbsp;
[![Renovate](https://img.shields.io/badge/renovate-enabled-blue?style=for-the-badge&logo=renovatebot)](https://www.mend.io/renovate/)

</div>

<div align="center">

[![Home Internet](https://img.shields.io/endpoint?url=https%3A%2F%2Fstatus.martinbjeldbak.com%2Fapi%2Fv1%2Fendpoints%2Fconnectivity_cloudflare%2Fhealth%2Fbadge.shields&style=flat-square&logo=ubiquiti&logoColor=white&label=Home%20Internet)](https://status.martinbjeldbak.com)&nbsp;&nbsp;
[![Status Page](https://img.shields.io/uptimerobot/status/m803027943-235bb98b0fa34da022c6632d?style=flat-square&logo=statuspage&logoColor=white&label=Status%20Page)](https://status.martinbjeldbak.com)&nbsp;&nbsp;
[![Alertmanager](https://img.shields.io/endpoint?url=https%3A%2F%2Fhealthchecks.io%2Fb%2F3%2F5af11ed2-6536-41f5-b4d1-f1f90254c0e5.shields&style=flat-square&label=Alertmanager)](https://healthchecks.io)

</div>


<div align="center">

[![Age](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.martinbjeldbak.com%2Fcluster_birth_age&style=flat-square&label=Age)](https://github.com/home-operations/kromgo)&nbsp;&nbsp;
[![Uptime](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.martinbjeldbak.com%2Fcluster_uptime_age&style=flat-square&label=Uptime)](https://github.com/home-operations/kromgo)&nbsp;&nbsp;
[![Nodes](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.martinbjeldbak.com%2Fcluster_node_count&style=flat-square&label=Nodes)](https://github.com/home-operations/kromgo)&nbsp;&nbsp;
[![Pods](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.martinbjeldbak.com%2Fcluster_pod_count&style=flat-square&label=Pods)](https://github.com/home-operations/kromgo)&nbsp;&nbsp;
[![CPU](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.martinbjeldbak.com%2Fcluster_cpu_usage&style=flat-square&label=CPU)](https://github.com/home-operations/kromgo)&nbsp;&nbsp;
[![Memory](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.martinbjeldbak.com%2Fcluster_memory_usage&style=flat-square&label=Memory)](https://github.com/home-operations/kromgo)&nbsp;&nbsp;
[![UPS Load](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.martinbjeldbak.com%2Fcluster_power_usage&style=flat-square&label=UPS%20Load)](https://github.com/home-operations/kromgo)&nbsp;&nbsp;
[![Alerts](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.martinbjeldbak.com%2Fcluster_alert_count&style=flat-square&label=Alerts)](https://github.com/home-operations/kromgo)

</div>


---

## 📖 Overview

This is a mono repository for my home infrastructure and Kubernetes cluster.
I run [Talos Linux](https://github.com/siderolabs/talos) on bare-metal and
follow Infrastructure as Code (IaC) principles using
[Flux](https://github.com/fluxcd/flux2),
[Renovate](https://github.com/renovatebot/renovate), [GitHub
Actions](https://github.com/features/actions), among other tools in my cluster.

This README outlines the software and hardware that runs inside my cluster.
I will try and keep ti updated as I make changes, but it might be outdated. As
my cluster is managed via GitOps, the files in this repo are source of truth :)

If you have any questions or comments, you can find me on the [Home
Operations](https://discord.gg/home-operations) Discord community and my email
in my GitHub profile.

## 🚢 Technology Stack

|                                                                                                                                               | Name                                                                                             | Description                                                          |
| :-------------------------------------------------------------------------------------------------------------------------------------------: | ------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------- |
|                            <img width="32" src="https://avatars.githubusercontent.com/u/13804887?v=4">                                        | [Talos Linux](https://github.com/siderolabs/talos)                                               | Immutable Linux distribution for Kubernetes.                         |
|      <img width="28" src="https://raw.githubusercontent.com/cncf/artwork/main/projects/flux/icon/color/flux-icon-color.svg">                  | [Flux](https://github.com/fluxcd/flux2)                                                          | GitOps tool reconciling sources from Git to Kubernetes.              |
|      <img width="32" src="https://raw.githubusercontent.com/cncf/artwork/main/projects/cilium/icon/color/cilium_icon-color.svg">              | [Cilium](https://github.com/cilium/cilium)                                                       | eBPF-based networking, observability, and security.                  |
|      <img width="32" src="https://raw.githubusercontent.com/cncf/artwork/main/projects/cert-manager/icon/color/cert-manager-icon-color.png"> | [Cert-manager](https://github.com/cert-manager/cert-manager)                                     | Certificate management for Kubernetes.                               |
|      <img width="32" src="https://raw.githubusercontent.com/cncf/artwork/main/projects/rook/icon/color/rook-icon-color.png">                  | [Rook-Ceph](https://github.com/rook/rook)                                                        | Ceph operator providing distributed block and object storage.        |
|                            <img width="32" src="https://avatars.githubusercontent.com/u/47803932?s=200&v=4">                                  | [Volsync](https://github.com/backube/volsync)                                                    | Persistent volume replication and backup to Synology NAS.            |
|                            <img width="32" src="https://avatars.githubusercontent.com/u/68335991?s=200&v=4">                                  | [External Secrets](https://github.com/external-secrets/external-secrets)                         | Sync secrets from 1Password into Kubernetes.                         |
|                            <img width="32" src="https://avatars.githubusercontent.com/u/100373852?s=200&v=4">                                 | [CloudNativePG](https://github.com/cloudnative-pg/cloudnative-pg)                                | PostgreSQL operator for Kubernetes.                                  |
|                            <img width="32" src="https://avatars.githubusercontent.com/u/104819355?s=200&v=4">                                 | [Dragonfly](https://github.com/dragonflydb/dragonfly)                                            | Redis-compatible in-memory data store.                               |
|                            <img width="32" src="https://avatars.githubusercontent.com/u/314135?s=200&v=4">                                    | [Cloudflare Tunnel](https://github.com/cloudflare/cloudflared)                                   | Encrypted tunnel securing external ingress traffic.                  |
|                            <img width="32" src="https://avatars.githubusercontent.com/u/36015203?s=200&v=4">                                  | [External DNS (Unifi)](https://github.com/kashalls/external-dns-unifi-webhook)                   | Automated private DNS records via UniFi.                             |
|                            <img width="32" src="https://avatars.githubusercontent.com/u/36015203?s=200&v=4">                                  | [External DNS (Cloudflare)](https://github.com/kubernetes-sigs/external-dns)                     | Automated public DNS records via Cloudflare.                         |
|                            <img width="32" src="https://avatars.githubusercontent.com/u/163326380?s=200&v=4">                                 | [Spegel](https://github.com/spegel-org/spegel)                                                   | Peer-to-peer OCI registry mirror across cluster nodes.               |
|                            <img width="32" src="https://avatars.githubusercontent.com/u/15930712?s=200&v=4">                                  | [Stakater Reloader](https://github.com/stakater/Reloader)                                        | Automatic pod restarts on ConfigMap/Secret changes.                  |
|                            <img width="32" src="https://raw.githubusercontent.com/TwiN/gatus/master/web/app/public/logo-192x192.png">            | [Gatus](https://github.com/TwiN/gatus)                                                           | Service health monitoring.                                        |
|                            <img width="32" src="https://avatars.githubusercontent.com/u/38656520?s=200&v=4">                                  | [Renovate](https://github.com/renovatebot/renovate)                                              | Dependency updates for Helm charts and container images.             |

## ☁️ Cloud Services

While I try to minimise cloud service usage, some are are necessary for if
I one day am gone - for example email servers and password managers is simply
not worth self-hosting if you ask me.


| Service       | Usage                                          | Cost (AUD)        |
| :------------ | :--------------------------------------------- | :---------------- |
| [1Password](https://1password.com)         | Secrets management via External Secrets        | ~$100/year        |
| [Backblaze B2](https://backblaze.com)      | S3-compatible object storage                   | ~$40/year         |
| [Cloudflare](https://cloudflare.com)       | Tunnel and DNS                                 | Free              |
| [Fastmail](https://fastmail.com)           | Email hosting                                  | ~$90/year         |
| [GitHub](https://github.com)               | Code repository and CI/CD automation           | Free              |
| [Healthchecks.io](https://healthchecks.io) | Uptime monitoring                              | Free              |
| [Let's Encrypt](https://letsencrypt.org)   | Public certificate authority                   | Free              |
| [Porkbun](https://porkbun.com)             | Domain registrar                               | ~$18/year         |
| [Pushover](https://pushover.net)           | Mobile push notifications                      | $7.99 OTP         |
| [UptimeRobot](https://uptimerobot.com)     | External status page monitoring                | Free              |
|               | **Total**                                      | ~$24/month        |

## 🔧 Hardware

All hardware except the UPS, router, and 2.5GbE switch is mounted in a 10" [DeskPi RackMate T2](https://deskpi.com/products/deskpi-rackmate-t2-rackmount-12u-server-cabinet-for-network-servers-audio-and-video-equipment) rack (see below for image).


| Device                   | Description                         | RAM  | Disk           |
| ------------------------ | ----------------------------------- | ---- | -------------- |
| UniFi Cloud Gateway Fiber | Router                             | —    | —              |
| UniFi Flex 2.5G PoE      | 2.5GbE switch                       | —    | —              |
| UniFi Lite 16 PoE        | 1GbE switch                         | —    | —              |
| Beelink EQi12 (i5-1220P) | Kubernetes control plane (`k8s-0`)  | 24GB | 500GB NVMe (OS)<br>1TB Samsung 990 PRO NVMe (Rook-Ceph) |
| Beelink EQ14 (N150)      | Kubernetes control plane (`k8s-1`)  | 32GB | 512GB SSD (OS)<br>1TB Samsung 990 PRO NVMe (Rook-Ceph) |
| HP EliteDesk 800 G6 Mini (i5-10500) | Kubernetes control plane (`k8s-2`)  | 32GB | 256GB NVMe (OS)<br>1TB Samsung 990 PRO NVMe (Rook-Ceph) |
| Synology DS920+          | Backup repository and media store   | —    | 2×18TB + 2×16TB HDD, 1TB WD Black NVMe |
| JetKVM (×3)              | Out-of-band KVM for control planes | —    | —              |
| SMLIGHT SLZB-06M         | Zigbee coordinator                  | —    | —              |
| [10″ Rack PDU](https://www.aliexpress.com/item/1005011702685079.html) | Power strip                         | —    | —              |
| Eaton 5E 1100i           | 1100 VA UPS                         | —    | —              |

<details>
  <summary>Expand to see my rack</summary>

  <img src="https://github.com/user-attachments/assets/326dbc6a-8b93-4f5d-b180-520ba147ab95" width="600" alt="homelab" />

</details>

## Acknowledgments

Thanks to the to [onedr0p](https://github.com/onedr0p) for the
[cluster-template](https://github.com/onedr0p/cluster-template) repository that
got this project started as previously I was deploying services using
a completely unmaintainable [1400+ line docker-compose
file](https://github.com/martinbjeldbak/self-hosted/blob/main/docker-compose.yml).
This repository itself is heavily inspired by (essentially a fork) his
[onedr0p/home-ops](https://github.com/onedr0p/home-ops) repo. Also be sure to
check out [kubesearch.dev](https://kubesearch.dev/) for ideas on how to deploy
applications.

I was also inspired to deploy all hardware into a 10" minirack by Jeff
Geerling's [mini-rack](https://github.com/geerlingguy/mini-rack) project!
