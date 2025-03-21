
variable "talos_version_spec" {
  type = object({
    number      = optional(string)
    pattern     = optional(string)
    stable_only = optional(bool, true)
  })
  default     = { pattern = ".*" }
  nullable    = false
  description = <<-EOT
    A specification to describe what Talos version number to pull. One, and only
    one of `number` or `pattern` must be provided.

    * `number`: An exact version number to use. Must match an existing Talos version
          number exactly. May be a pre-release version number if `stable_only`
          is `false`.
    * `pattern`: A regex pattern that will be matched against to find eligible
          Talos versions. The latest matching version will be used.
    * `stable_only`: When `true`, only stable versions will be considered.
  EOT
}

variable "find_extensions" {
  type        = list(string)
  nullable    = false
  default     = []
  description = <<-EOT
    List of extension names that will be used to search the extension list.
  EOT
}

variable "extensions" {
  type        = list(string)
  nullable    = false
  default     = []
  description = <<-EOT
    List of extensions that will be added as-is to the schematic
    configuration of `officialExtensions`.
  EOT
}

variable "pve_iso_storage" {
  type = object({
    host_name    = string
    datastore_id = optional(string, "local")
  })
  description = "The Proxmox ISO storage location."
}

variable "file_name_label" {
  type = object({
    namespace           = optional(string, "talos")
    schematic_id_length = optional(number, 8)
    attributes          = optional(list(string), [])
    label_order = optional(list(string), [
      "namespace", "version", "platform", "architecture",
      "schematic_id", "attributes",
    ])
    delimiter = optional(string, "-")
    extension = optional(string, "img")
  })
  default     = {}
  description = "The configuration to generate the file name."
}
