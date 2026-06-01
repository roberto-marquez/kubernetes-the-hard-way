variable "aws_region" {
  description = "AWS region to deploy into."
  type        = string
}

variable "name" {
  type = string
}

variable "cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "known_ips" {
  description = "Known IPs to ssh from"
  type        = list(string)
}

variable "assign_public_ip_on_public_subnet" {
  type        = bool
  description = "Whether to automatically map a public ip to ec2 instances launched on the public subnet"
}

variable "tags" {
  type = map(string)
  default = {}
}
