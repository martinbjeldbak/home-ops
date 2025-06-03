terraform {
  required_version = "v1.9"
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.78.1"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_api_endpoint
  api_token = var.proxmox_api_token
  insecure  = false
  ssh {
    agent    = true
    username = "root" # TODO: create opentofu user to use insted https://registry.terraform.io/providers/bpg/proxmox/latest/docs#ssh-connection
    password = var.proxmox_ssh_password
  }
}
