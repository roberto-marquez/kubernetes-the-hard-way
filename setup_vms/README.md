# Setup for VMs

This directory contains the terraform needed to provision the VMs needed for this project in AWS.

## Prerequisites

- Terraform 1.5+
- AWS credentials configured (one of):
  - `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY` (and optional `AWS_SESSION_TOKEN`)
  - An AWS profile in `~/.aws/credentials`
  - Any other credential mechanism supported by the AWS provider

## Variables

- `aws_region` (default: `ap-southeast-2`)

## Usage

```bash
cd setup_vms
terraform init
terraform plan
terraform apply
```

## Clean up

```bash
terraform destroy
```
