terraform {
  required_version = "v1.9"
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.70.1"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_api_endpoint
  api_token = var.proxmox_api_token
  insecure  = true # TODO: false when we have reverse proxy in front
  ssh {
    agent    = true
    username = "root" # TODO: create opentofu user to use insted https://registry.terraform.io/providers/bpg/proxmox/latest/docs#ssh-connection
  }
}
