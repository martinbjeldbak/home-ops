
resource "proxmox_virtual_environment_download_file" "proxmox_backup_server_3_3" {
  content_type = "iso"
    datastore_id =  "backups"
  file_name = "proxmox-backup-server_3.3-1.iso"
  node_name ="beelink-eq14-1"
  url = "https://enterprise.proxmox.com/iso/proxmox-backup-server_3.3-1.iso"
}

resource "proxmox_virtual_environment_vm" "proxmox_backup_server" {
  vm_id = "110"
  name      = "proxmox-backup-server"
  description = "managed by OpenTofu"
  node_name = "beelink-eq14-1"
  tags = ["opentofu", "pbs"]
  reboot_after_update     = true

  cpu {
    cores = 4
    type = "host"
  }

  memory {
    dedicated = 4096
    floating  = 0
  }

  # Uncommented 2025-02-09 now that it's installed
  #cdrom {
  #  enabled = true
  #  file_id      = proxmox_virtual_environment_download_file.proxmox_backup_server_3_3.id
  #  interface = "ide0"
  #}

  # boot_order = ["scsi0"]

  # data disk
  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    iothread     = true
    size         = 20
    file_format = "raw"
    cache = "writethrough"
    ssd = true
  }

  scsi_hardware = "virtio-scsi-single"

  network_device {
    bridge = "vmbr0"
  }

  efi_disk {
    datastore_id = "local-lvm"
    type = "4m"
  }

  bios = "ovmf" # eufi
  machine = "q35"

  # should be true if qemu agent is not installed / enabled on the VM
  stop_on_destroy = true

  initialization {
    datastore_id = "local-lvm"
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  operating_system {
    type = "l26"  # Linux Kernel 2.6 - 6.X.
  }
}
