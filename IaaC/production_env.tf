resource "proxmox_vm_qemu" "worker_node" {

  target_node = var.target_node_name
  clone       = var.clone_name
  count       = 2
  name        = "staging-${count.index + 1}"
  vmid        = "30${count.index + 1}"
  desc        = "Testing nodes for pipeline"

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

resource "proxmox_vm_qemu" "production_node" {

  target_node = var.target_node_name
  clone       = var.clone_name
  count       = 2
  name        = "production-${count.index + 1}"
  vmid        = "30${count.index + 3}"
  desc        = "Production environment"

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

  ipconfig0 = "ip=192.168.0.15${count.index + 3}/24,gw=192.168.0.1"


  sshkeys = <<EOF
  ${var.ssh_rsa_pub}
  EOF
}

resource "proxmox_vm_qemu" "master_node" {

  target_node = var.target_node_name
  clone       = var.clone_name
  count       = 1
  name        = "master-${count.index}"
  vmid        = "30${count.index}"
  desc        = "Production master node"

  os_type    = "cloud-init"
  agent      = 1
  memory     = 5120
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
    size     = "60G"
    iothread = 0
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=192.168.0.15${count.index}/24,gw=192.168.0.1"


  sshkeys = <<EOF
  ${var.ssh_rsa_pub}
  EOF
}
