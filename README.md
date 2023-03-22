# Run an EAA Connector on Linode

## Features

- Spin up an EAA Connector in Linode
- Hide the connector behind a Linode Firewall

## Requirements

- A linode account
- An Akamai Account with Enterprise Application Access

## Step by step

## 1. Edit the Terraform variable

Clone the file `terraform-script/var-files/example.tfvars`  
and edit each variable.

## 2. Let's spin up the EAA Connector

```bash
cd terraform-script
terraform init
terraform plan
terraform apply
```

## 3. Remove the connector

```bash
terraform destroy
```

Manually remove the connector from your Akamai Configuration
