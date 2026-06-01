
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.name
  cidr = var.cidr

  azs                     = var.azs
  private_subnets         = var.private_subnets
  public_subnets          = var.public_subnets
  map_public_ip_on_launch = var.assign_public_ip_on_public_subnet

  enable_nat_gateway = true

  create_elasticache_subnet_group = false
  create_egress_only_igw          = false
  create_redshift_subnet_group    = false



  tags = var.tags
}
