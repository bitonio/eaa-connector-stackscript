
terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
    }
  }
}

# Configure the Linode Provider
provider "linode" {
  token = var.linode_api_token
}

resource "linode_stackscript" "eaa-connector-stackscript" {
  label = "eaa-connector-stackscript"
  description = "Install EAA Connector as Container on a Ubuntu LTS Host"
  script = file("${path.root}/../eaa-connector-stackscript.bash")
  images = ["linode/ubuntu22.04", ]
  rev_note = "Create from Terraform https://github.com/bitonio/eaa-connector-stackscript"
}

resource "linode_firewall" "eaa-connector-firewall" {
  label = "eaa-connector-firewall"
  inbound { # Bogus outbound rule to satisfy Terraform
    label    = "allow-ssh"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound_policy = "DROP"
  outbound_policy = "ACCEPT"
  linodes = [linode_instance.eaa-connector.id, ]
}

resource "linode_instance" "eaa-connector" {
  image     = "linode/ubuntu22.04"
  label     = var.label
  region    = var.linode_region
  type      = var.linode_type
  root_pass = var.linux_root_password
  authorized_keys = var.linux_root_pubkeys
  stackscript_id = linode_stackscript.eaa-connector-stackscript.id
  stackscript_data = {
    "LABEL" = var.label
    "OPENAPI_HOST" = var.openapi_host
    "OPENAPI_CLIENT_SECRET" = var.openapi_client_secret
    "OPENAPI_CLIENT_TOKEN" = var.openapi_client_token
    "OPENAPI_ACCESS_TOKEN" = var.openapi_access_token
    "OPENAPI_ACCOUNT_KEY" = var.openapi_account_key
  }
}