
resource "proxmox_virtual_environment_vm" "talos_node_02" {
  vm_id = "201"
  name      = "node-02"
  description = "managed by OpenTofu"
  node_name = "beelink-eqi12-1"
  tags = ["opentofu", "talos"]

  cpu {
    cores = 10
    type = "host"
  }

  memory {
    dedicated =  24576
    floating  = 0
  }

  # Uncommented 2025-02-09 now that it's installed
  cdrom {
    file_id      = proxmox_virtual_environment_download_file.talos_secureboot.id
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
    mtu = 1200
    bridge = "vmbr0"
    disconnected = false
    mac_address  = "BC:24:11:9B:A8:42"
    vlan_id = 0
  }

  network_device { # USER network device (net2)
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    firewall     = false
    mac_address  = "BC:24:11:51:22:6C"
    model        = "virtio"
    mtu          = 1200
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
}
