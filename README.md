# AWS Customer Gateway module

Terraform module which creates Customer Gateway resources on AWS.

These types of resources are supported:

* [AWS Customer Gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway)


## Usage
### Create Customer Gateway

main.tf
```hcl
module "cgw" {
  source = "git@github.com:jangjaelee/terraform-aws-customer-gateway.git"

  cgw_name    = var.cgw_name
  bgp_asn     = var.bgp_asn
  ip_addr     = var.ip_addr
  type        = var.type
  device_name = var.device_name

  env = var.env
}
```

providers.tf
```hcl
provider "aws" {
  region = var.region
  allowed_account_ids = var.account_id
  profile = "eks_service"
}
```

terraform.tf
```hcl
terraform {
  required_version = ">= 0.15.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.43.0"
    }
  }

  backend "s3" {
    bucket = "kubesphere-terraform-state-backend"
    key = "kubesphere/cgw/terraform.tfstate"
    dynamodb_table = "kubesphere-terraform-state-locks"
    encrypt = true
    region = "ap-northeast-2"
    profile = "eks_service"
  }
}
```

variables.tf
```hcl
variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-northeast-2"
}

variable "account_id" {
  description = "List of Allowed AWS account IDs"
  type        = list(string)
  default     = ["1234567890"]
}

variable "cgw_name" {
  description = "Name to be used on all the resources as identifier for Customer Gateway"
  type        = string
}

variable "bgp_asn" {
  description = "The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN)"
  type        = number
}

variable "ip_addr" {
  description = "The IP address of the gateway's Internet-routable external interface"
  type        = string
}

variable "type" {
  description = "The type of customer gateway. The only type AWS supports at this time is "ipsec.1""
  type        = string
  default     = "ipsec.1"
}

variable "device_name" {
  description = "A name for the customer gateway device"
  type        = string
  default     = ""
}

variable "env" {
  description = "Environment"
  type        = string
}
```

terraform.tfvars
```hcl
region      = "ap-northeast-2"
account_id  = ["123456789012"]
cgw_name    = "KubeSphere-dev"
bgp_asn     = 65000
ip_addr     = ""
type        = "ipsec.1"
device_name = ""
env         = "dev"
```

output.tf
```hcl
output "aws_customer_gateway_id" {
  value = module.cgw.aws_customer_gateway_id
}

output "aws_customer_gateway_arn" {
  value = module.cgw.aws_customer_gateway_arn
}

output "aws_customer_gateway_tags_all" {
  value = module.cgw.aws_customer_gateway_tags_all
}
```
