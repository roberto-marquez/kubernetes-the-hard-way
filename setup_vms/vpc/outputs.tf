output "security_group_ids" {
  value = [aws_security_group.allow_all_outbound.id, aws_security_group.allow_all_same_vpc.id, aws_security_group.allow_ssh_from_known_ips.id]
}

output "id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}
