# Linode name appearing in Linode Cloud UI and Akamai Enterprise Center
output "label" {
  value = linode_instance.eaa-connector.label
}

# IP address to SSH to
output "ipv4" {
  value = linode_instance.eaa-connector.ip_address
}