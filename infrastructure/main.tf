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
  token_name      = "tk1"
  user_id         = proxmox_virtual_environment_user.kubernetes_csi.user_id
}
