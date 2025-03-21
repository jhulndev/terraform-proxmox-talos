# Proxmox Talos Image Terraform module


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >= 0.73 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | >= 0.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | >= 0.73 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_talos_image_factory"></a> [talos\_image\_factory](#module\_talos\_image\_factory) | jhulndev/image-factory/talos | 1.0.3 |

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_download_file.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_download_file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_talos_version_spec"></a> [talos\_version\_spec](#input\_talos\_version\_spec) | A specification to describe what Talos version number to pull. One, and only<br/>one of `number` or `pattern` must be provided.<br/><br/>* `number`: An exact version number to use. Must match an existing Talos version<br/>      number exactly. May be a pre-release version number if `stable_only`<br/>      is `false`.<br/>* `pattern`: A regex pattern that will be matched against to find eligible<br/>      Talos versions. The latest matching version will be used.<br/>* `stable_only`: When `true`, only stable versions will be considered. | <pre>object({<br/>    number      = optional(string)<br/>    pattern     = optional(string)<br/>    stable_only = optional(bool, true)<br/>  })</pre> | <pre>{<br/>  "pattern": ".*"<br/>}</pre> | no |
| <a name="input_find_extensions"></a> [find\_extensions](#input\_find\_extensions) | List of extension names that will be used to search the extension list. | `list(string)` | `[]` | no |
| <a name="input_extensions"></a> [extensions](#input\_extensions) | List of extensions that will be added as-is to the schematic<br/>configuration of `officialExtensions`. | `list(string)` | `[]` | no |
| <a name="input_pve_iso_storage"></a> [pve\_iso\_storage](#input\_pve\_iso\_storage) | The Proxmox ISO storage location. | <pre>object({<br/>    host_name    = string<br/>    datastore_id = optional(string, "local")<br/>  })</pre> | n/a | yes |
| <a name="input_file_name_label"></a> [file\_name\_label](#input\_file\_name\_label) | The configuration to generate the file name. | <pre>object({<br/>    namespace           = optional(string, "talos")<br/>    schematic_id_length = optional(number, 8)<br/>    attributes          = optional(list(string), [])<br/>    label_order = optional(list(string), [<br/>      "namespace", "version", "platform", "architecture",<br/>      "schematic_id", "attributes",<br/>    ])<br/>    delimiter = optional(string, "-")<br/>    extension = optional(string, "img")<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_talos_version"></a> [talos\_version](#output\_talos\_version) | The final Talos version that was used. |
| <a name="output_pve_disk_image_file"></a> [pve\_disk\_image\_file](#output\_pve\_disk\_image\_file) | The disk image to use to boot Proxmox VMs. |
| <a name="output_installer_url"></a> [installer\_url](#output\_installer\_url) | Use this installer image for upgrades. |
<!-- END_TF_DOCS -->
