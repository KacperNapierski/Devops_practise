resource "proxmox_vm_qemu" "worker_node" {

    target_node = "production"
    count = 2
    name = "worker-node-${count.index + 1}"
    vmid = "30${count.index + 1}"
    desc = "Ubuntu Server based worker VM"
    iso = "ubuntu-22.04.1-live-server-amd64.iso"
    onboot = true

    memory = 1024
    sockets = 1
    cores = 1
    scsihw = "virtio-scsi-single"
    #ipconfig0 = "ip = 192.168.0.15${count.index + 1}/24, gw = 192.168.0.1"

    network {
        model = "virtio"
        bridge = "vmbro"
    }

    disk {
        type = "scsi"
        storage = "local-lvm"
        size = "20G"
    }
}