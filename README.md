# Run an EAA Connector on Linode

Warning: This is an unofficial capability that is not officially supported by Linode or Akamai Technologies. Use at your own risk.

## Features

- Spin up an EAA Connector in Linode
- Hide the connector behind a Linode Firewall

## Requirements

- A linode account
- An Akamai Account with Enterprise Application Access

## Step by step

## 1. Create your Terraform variables file

Clone the file `terraform-script/var-files/example.tfvars`  
and edit each variable.

## 2. Let's spin up the EAA Connector

```bash
cd terraform-script
terraform init
terraform plan -var-file=var-files/yourfile.tfvars
terraform apply -var-file=var-files/yourfile.tfvars
```

## 3. Remove the connector

```bash
terraform destroy
```

Manually remove the connector from your Akamai Configuration
