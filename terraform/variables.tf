variable "proxmox_api_token" {
  type = string
  description = "Proxmox cluster API endpoint https://proxmox-01.my-domain.net:8006"
}

variable "proxmox_ssh_password" {
  type = string
  description = "Proxmox VE password for ssh conection"
}

variable "proxmox_api_endpoint" {
  type = string
  description = "Proxmox API token bpg proxmox provider with ID and token"
}

variable "proxmox_cloudflare_token" {
  type = string
  description = "Proxmox Cloudflare Token for the Cloudflare ACME plugin"
}

variable "proxmox_cloudflare_email" {
  type = string
  description = "Proxmox Cloudflare Admin email for the Cloudflare ACME plugin"
}
