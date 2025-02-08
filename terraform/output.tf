output "kubernetes_csi_user_token" {
  sensitive = true

value = proxmox_virtual_environment_user_token.kubernetes_csi.value
}
