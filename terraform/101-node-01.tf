resource "proxmox_virtual_environment_download_file" "talos_secureboot" {
  content_type = "iso"
    datastore_id =  "backups"
  file_name = "metal-amd64-secureboot.iso"
  node_name ="beelink-eq14-1"
  url = "https://factory.talos.dev/image/376567988ad370138ad8b2698212367b8edcb69b5fd68c80be1f2ec7d603b4ba/v1.9.3/metal-amd64-secureboot.iso"
}

resource "proxmox_virtual_environment_download_file" "talos" {
  content_type = "iso"
    datastore_id =  "backups"
  file_name = "metal-amd64.iso"
  node_name ="beelink-eq14-1"
  url = "https://factory.talos.dev/image/376567988ad370138ad8b2698212367b8edcb69b5fd68c80be1f2ec7d603b4ba/v1.9.3/metal-amd64.iso"
}

resource "proxmox_virtual_environment_vm" "talos_node_01" {
  vm_id = "101"
  name      = "node-01"
  description = "managed by OpenTofu"
  node_name = "beelink-eq14-1"
  tags = ["opentofu", "talos"]

  cpu {
    cores = 4
    type = "x86-64-v2-AES"
  }

  memory {
    dedicated =  32768
    floating  = 32768
  }

  # Uncommented 2025-02-09 now that it's installed
  cdrom {
    # file_id      = proxmox_virtual_environment_download_file.talos_secureboot.id
    interface = "ide0"
  }

  # boot_order = ["scsi0"]

  # data disk
  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    iothread     = true
    size         = 32
    file_format = "raw"
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
