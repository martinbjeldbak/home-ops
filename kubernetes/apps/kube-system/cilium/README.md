# Cilium

## OPNsense BGP

Set up using below guides combined with [onedr0p's setup](https://github.com/onedr0p/home-ops/tree/5f0a794919336df2bca41f60e2f0e8346e490b1a/kubernetes/apps/kube-system/cilium).

- <https://dickingwithdocker.com/posts/using-bgp-to-integrate-cilium-with-opnsense/>
- <https://dickingwithdocker.com/posts/update-using-bgp-to-integrate-cilium-with-opnsense/>

From "Running Configuration" tab in <https://192.168.1.1/ui/quagga/diagnostics/general>

```txt
router bgp 64513
 no bgp ebgp-requires-policy
 no bgp default ipv4-unicast
 neighbor 192.168.42.10 remote-as 64514
 neighbor 192.168.42.10 update-source em0
 !
 address-family ipv4 unicast
  network 192.168.1.0/24
  neighbor 192.168.42.10 activate
  neighbor 192.168.42.10 next-hop-self
  neighbor 192.168.42.10 soft-reconfiguration inbound
 exit-address-family
exit
```
