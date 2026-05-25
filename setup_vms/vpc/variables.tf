variable "aws_region" {
  description = "AWS region to deploy into."
  type        = string
  default     = "ap-southeast-2"
}

variable "name" {
  type    = string
  default = "k8s-vpc"
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "azs" {
  type    = list(string)
  default = ["ap-southeast-2a"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.101.0/24"]
}

variable "known_ips" {
  description = "Known IPs to ssh from"
  type        = list(string)
}

variable "tags" {
  type = object({
    Terraform = string
    Project   = string
  })
  default = {
    Terraform = "true"
    Project   = "K8S-HardWay"
  }
}
