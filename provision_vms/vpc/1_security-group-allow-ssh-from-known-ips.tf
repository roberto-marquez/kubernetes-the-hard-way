resource "aws_security_group" "allow_ssh_from_known_ips" {
  name        = "allow-ssh-from-known-ips"
  description = "Allows to ssh from known IPs"
  vpc_id      = module.vpc.vpc_id

  tags = merge(
    { "Name" = "allow-ssh-from-known-ips:sg" },
    var.tags
  )
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_from_known_ips" {
  for_each          = toset(var.known_ips)
  security_group_id = aws_security_group.allow_ssh_from_known_ips.id
  cidr_ipv4         = "${each.value}/32"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22

  tags = merge(
    { "Name" = "allow-ssh-from-known-ip:${each.value}:sg_ir" },
    var.tags
  )
}
