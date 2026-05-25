resource "aws_security_group" "allow_all_outbound" {
  name        = "allow-all-outbound"
  description = "Allows all outbound traffic"
  vpc_id      = module.vpc.vpc_id

  tags = merge(
    { "Name" = "allow-all-outbound:sg" },
    var.tags
  )
}

resource "aws_vpc_security_group_egress_rule" "allow_all_out_traffic_ipv4" {
  security_group_id = aws_security_group.allow_all_outbound.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = merge(
    { "Name" = "allow-all-outbound-ipv4:sg_or" },
    var.tags
  )
}

resource "aws_vpc_security_group_egress_rule" "allow_all_out_traffic_ipv6" {
  security_group_id = aws_security_group.allow_all_outbound.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"

  tags = merge(
    { "Name" = "allow-all-outbound-ipv6:sg_or" },
    var.tags
  )
}
