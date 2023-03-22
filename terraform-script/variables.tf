variable "label" {
    default = "eaa-connector-from-stackscript"
    type = string
    description = "Name of the connector (in Linode and Enterprise Center)"
}

variable "linode_api_token" {
  default = ""
  type = string
  description = "Linode API token"
}

variable "linode_region" {
  default = "us-east"
  type = string
  description = "Linode Region"
}

variable "linode_type" {
  default = "g6-standard-2"
  type = string
  description = <<EOT
  Type of Linode instance. 
  See GET https://api.linode.com/v4/linode/types for available type codes."
  EOT
}

variable "openapi_host" {
  default = ""
  type = string
  description = "{OPEN} API Host"
}

variable "openapi_client_secret" {
  default = ""
  type = string
  description = "{OPEN} API Client Secret"
}

variable "openapi_client_token" {
  default = ""
  type = string
  description = "{OPEN} API Client Token"
}

variable "openapi_access_token" {
  default = ""
  type = string
  description = "{OPEN} API Access Secret"
}

variable "openapi_account_key" {
  default = ""
  type = string
  description = "{OPEN} API Account Key (optional)"
}


variable "linux_root_pubkeys" {
  default = null
  type = list(string)
  description = "Linux Root SSH Keys"
}

variable "linux_root_password" {
  default = null
  type = string
  description = "Linux Root Password (for troubleshooting if the Windows box doesn't came up)"
}