
output "talos_version" {
  value       = module.talos_image_factory.talos_version
  description = "The final Talos version that was used."
}

output "pve_disk_image_file" {
  value = {
    id           = proxmox_virtual_environment_download_file.this.id
    file_name    = proxmox_virtual_environment_download_file.this.file_name
    node_name    = proxmox_virtual_environment_download_file.this.node_name
    content_type = proxmox_virtual_environment_download_file.this.content_type
    datastore_id = proxmox_virtual_environment_download_file.this.datastore_id
  }
  description = "The disk image to use to boot Proxmox VMs."
}

output "installer_url" {
  value       = module.talos_image_factory.urls.installer
  description = "Use this installer image for upgrades."
}
