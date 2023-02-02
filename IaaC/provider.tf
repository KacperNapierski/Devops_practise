terraform {
  required_version = ">=0.13.0"

  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.11"
    }
  }
}

variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type      = string
  sensitive = true
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

variable "cloud_init_ciuser" {
  type      = string
  sensitive = true
}

variable "cloud_init_cipassword" {
  type      = string
  sensitive = true
}

variable "ssh_rsa_pub" {
  type = string

}

variable "clone_name" {
  type = string
}

variable "target_node_name" {
  type = string
}

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
  pm_tls_insecure     = true
}
