resource "proxmox_virtual_environment_download_file" "talos_secureboot" {
  content_type = "iso"
    datastore_id =  "backups"
  file_name = "metal-amd64-secureboot.iso"
  node_name ="beelink-eq14-1"
  url = "https://factory.talos.dev/image/376567988ad370138ad8b2698212367b8edcb69b5fd68c80be1f2ec7d603b4ba/v1.9.5/metal-amd64-secureboot.iso"
}

resource "proxmox_virtual_environment_vm" "talos_node_01" {
  vm_id = "101"
  name      = "node-01"
  description = "managed by OpenTofu"
  node_name = "beelink-eq14-1"
  tags = ["opentofu", "talos"]

  cpu {
    cores = 4
    type = "host"
  }

  memory {
    dedicated = 28672
    floating  = 0
  }

  # Uncommented 2025-02-09 now that it's installed
  #cdrom {
  #  enabled = false
  #  # file_id      = proxmox_virtual_environment_download_file.talos_secureboot.id
  #  interface = "ide0"
  #}

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
    mtu = 1420
    bridge = "vmbr0"
    disconnected = false
    mac_address  = "BC:24:11:9B:F9:42"
    vlan_id = 0
  }

  network_device { # USER network device (net2)
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    firewall     = false
    mac_address  = "BC:24:11:51:22:6C"
    model        = "virtio"
    mtu          = 1420
    queues       = 0
    rate_limit   = 0
    vlan_id = 20
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

  vga {
    type = "none" # already set up talos
  }
}
