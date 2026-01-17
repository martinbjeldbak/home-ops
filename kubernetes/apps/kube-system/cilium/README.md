# Cilium

## Unifi BGP

## OPNsense BGP

Set up using below guides combined with [onedr0p's setup](https://github.com/onedr0p/home-ops/tree/5f0a794919336df2bca41f60e2f0e8346e490b1a/kubernetes/apps/kube-system/cilium).

- <https://dickingwithdocker.com/posts/using-bgp-to-integrate-cilium-with-opnsense/>
- <https://dickingwithdocker.com/posts/update-using-bgp-to-integrate-cilium-with-opnsense/>

From "Running Configuration" tab in <https://192.168.1.1/ui/quagga/diagnostics/general>

```
router bgp 64513
  bgp router-id 192.168.1.1
  no bgp ebgp-requires-policy

  neighbor k8s peer-group
  neighbor k8s remote-as 64514

  neighbor 192.168.42.10 peer-group k8s
  neighbor 192.168.42.11 peer-group k8s
  neighbor 192.168.42.12 peer-group k8s

  address-family ipv4 unicast
    neighbor k8s next-hop-self
    neighbor k8s soft-reconfiguration inbound
  exit-address-family
exit
```
