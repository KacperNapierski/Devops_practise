resource "proxmox_vm_qemu" "worker_node" {

  target_node = var.target_node_name
  clone       = var.clone_name
  count       = 2
  name        = "worker-node-${count.index + 1}"
  vmid        = "30${count.index + 1}"
  desc        = "Ubuntu Server based worker VM"

  os_type    = "cloud-init"
  agent      = 1
  memory     = 1024
  sockets    = 1
  cores      = 1
  cpu        = "host"
  scsihw     = "virtio-scsi-pci"
  bootdisk   = "scsi0"
  ciuser     = var.cloud_init_ciuser
  cipassword = var.cloud_init_cipassword



  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  disk {
    slot     = 0
    type     = "scsi"
    storage  = "local-lvm"
    size     = "20G"
    iothread = 0
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=192.168.0.15${count.index + 1}/24,gw=192.168.0.1"


  sshkeys = <<EOF
  ${var.ssh_rsa_pub}
  EOF
}
