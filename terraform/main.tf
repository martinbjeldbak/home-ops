# proxmox csi
resource "proxmox_virtual_environment_role" "csi" {
  role_id = "csi"
  privileges = [
    "VM.Audit", "VM.Config.Disk", "Datastore.Allocate", "Datastore.AllocateSpace", "Datastore.Audit"
  ]
}

resource "proxmox_virtual_environment_user" "kubernetes_csi" {
  acl {
    path = "/"
    propagate = true
    role_id =  proxmox_virtual_environment_role.csi.role_id
  }
  user_id = "kubernetes-csi@pve"
}

resource "proxmox_virtual_environment_user_token" "kubernetes_csi" {
  comment         = "Managed by OpenTofu"
  expiration_date = "2033-01-01T22:00:00Z"
  token_name      = "csi"
  privileges_separation = false # token has same permission as user
  user_id         = proxmox_virtual_environment_user.kubernetes_csi.user_id
}

resource "proxmox_virtual_environment_acme_dns_plugin" "cloudflare_dns" {
  plugin = "cloudflare-dns"
  api    = "cf"
  data = {
    CF_Email= var.proxmox_cloudflare_email
    CF_Token=var.proxmox_cloudflare_token
  }
}
