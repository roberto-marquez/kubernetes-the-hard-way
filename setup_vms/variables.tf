variable "aws_region" {
  description = "AWS region to deploy into."
  type        = string
  default     = "ap-southeast-2"
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
