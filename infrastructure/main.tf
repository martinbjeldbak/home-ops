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
