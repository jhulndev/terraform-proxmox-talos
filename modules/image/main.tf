
module "talos_image_factory" {
  source  = "jhulndev/image-factory/talos"
  version = "1.0.3"

  talos_version_spec = var.talos_version_spec
  find_extensions    = var.find_extensions

  # Depend on the qemu agent being available
  extensions = concat(["siderolabs/qemu-guest-agent"], var.extensions)

  # Proxmox can only run on amd64
  architecture = "amd64"

  # Use `nocloud` so that cloud-init can be used
  platform = "nocloud"
}

locals {
  talos_version = module.talos_image_factory.talos_version

  # Generate the file name label
  short_schematic_id = substr(
    module.talos_image_factory.schematic.id, 0,
    var.file_name_label.schematic_id_length
  )

  file_name_context = {
    namespace    = var.file_name_label.namespace
    attributes   = var.file_name_label.attributes
    version      = local.talos_version
    schematic_id = local.short_schematic_id
    platform     = "nocloud"
    architecture = "amd64"
  }

  file_name_parts = flatten([
    for l in var.file_name_label.label_order :
    local.file_name_context[l] if length(local.file_name_context[l]) > 0
  ])

  file_name = join(var.file_name_label.delimiter, local.file_name_parts)

}

resource "proxmox_virtual_environment_download_file" "this" {
  node_name    = var.pve_iso_storage.host_name
  datastore_id = var.pve_iso_storage.datastore_id
  content_type = "iso"

  url       = module.talos_image_factory.urls.disk_image
  file_name = "${local.file_name}.${var.file_name_label.extension}"

  # This seems to be safe to use for the disk_image urls event if it doesn't
  # have the .zst extension.
  decompression_algorithm = "zst"

  # The filesize will change because it is decompressed, causing a replacement
  # if this isn't set to false.
  overwrite = false
}
