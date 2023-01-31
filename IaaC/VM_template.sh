#!/bin/bash

get_basic_vm_settings(){
    read -p 'VM ID: ' vm_id
    read -p 'VM Name: ' vm_name
    read -p 'VM memory: ' vm_memory
    read -p 'VM cores: ' vm_core
}

#---------Requirements------------
rm focal-server-cloudimg-amd64.img
wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
apt update -y
apt install libguestfs-tools -y
echo 'Requirements downloaded'

get_basic_vm_settings

#---------Template creation-----------
qm create $vm_id --name $vm_name --memory $vm_memory --cores $vm_core --net0 virtio,bridge=vmbr0
qm importdisk $vm_id focal-server-cloudimg-amd64.img local
qm set $vm_id --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-$vm_id-disk-0
qm set $vm_id --boot c --bootdisk scsi0
qm set $vm_id --ide2 local-lvm:cloudinit
qm set $vm_id --serial0 socket --vga serial0
qm set $vm_id --agent enabled=1
qm template $vm_id
rm focal-server-cloudimg-amd64.img
echo 'Template created'