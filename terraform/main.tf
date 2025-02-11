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
  comment = "Managed by OpenTofu"
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

resource "proxmox_virtual_environment_group" "homepage" {
  comment  = "Managed by OpenTofu"
  group_id = "homepage"
}

resource "proxmox_virtual_environment_acl" "homepage_group_acl" {
  group_id =  proxmox_virtual_environment_group.homepage.group_id
  role_id = "PVEAuditor"

  path      = "/"
  propagate = true
}

resource "proxmox_virtual_environment_user" "homepage" {
  user_id = "homepage@pve"
  comment = "Managed by OpenTofu"
  groups = [
    proxmox_virtual_environment_group.homepage.group_id
  ]
}

resource "proxmox_virtual_environment_user_token" "homepage" {
  comment         = "Managed by OpenTofu"
  expiration_date = "2033-01-01T22:00:00Z"
  token_name      = "homepage"
  privileges_separation = false # token has same permission as user
  user_id         = proxmox_virtual_environment_user.homepage.user_id
}


resource "proxmox_virtual_environment_download_file" "proxmox_ubuntu" {
  content_type = "iso"
    datastore_id =  "backups"
  file_name = "ubuntu-24.04.1-desktop-amd64.iso"
  node_name ="beelink-eq14-1"
  url = "https://mirror.internet.asn.au/pub/ubuntu/releases/24.04.1/ubuntu-24.04.1-desktop-amd64.iso"
}
