resource "proxmox_vm_qemu" "worker_node" {

  target_node = "production"
  clone       = "ubuntu-2004-cloudinit-template"
  count       = 2
  name        = "worker-node-${count.index + 1}"
  vmid        = "30${count.index + 1}"
  #desc        = "Ubuntu Server based worker VM"

  os_type   = "cloud-init"
  onboot    = true
  agent     = 1
  memory    = 1024
  sockets   = 1
  cores     = 1
  scsihw    = "virtio-scsi-pci"
  bootdisk  = "scsi0"
  ipconfig0 = "ip = 192.168.0.15${count.index + 1}/24, gw = 192.168.0.1"

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  disk {
    slot     = 0
    type     = "scsi"
    storage  = "local-lvm"
    size     = "20G"
    iothread = 1
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  sshkeys = <<EOF
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXY5wKp6+K4b3u+QOIc3x+O4L4TuEiCc/DT5qMZaBaHcQhsp5/Jb8GQU1/zftE8uUOq/gmM8qQvvBRlpzsRGiYYoSCuog0bVd9j4srArhDoPXXFAvKwj3Nwnt7Adif9mq4H9emjcxqs3sa6T1PvN2+RqmkihBEcTPGinWKNYpKCt2FoGBGyELDrpXTr72pEaSW+LKfigokrA53AdqCnlgB40C+kc/ehVt01VGMZ0TXnrMGb2P3Fe5U/4YFyUcHLYMAFszSzjqYhiUvdMUhHmOyfBwP7bGDHDhi1d5t7D6OMolN/+nfwlZFEMVuZjxmCxypE0UEyqg1xUMgq/wM0636As8ZiDA7zIXrucGaHEnDcyVVtGqFwtE0uDCZ2HZba8y9eaf8Zrx+nt/WA6IMfqsQdwA6wiTUv+gKLgaF6CytUbYn7DOJvPCifx0Cu/344nLWhuLgw6ppptRkAniaYANGXDMONHqIaEWtRMcK5dIUeoTXHc38acASMWcsAhWFjRM= root@production
  EOF
}
