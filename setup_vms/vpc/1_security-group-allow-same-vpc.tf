resource "aws_security_group" "allow_all_same_vpc" {
  name        = "allow-all-same-vpc"
  description = "Allows all traffic from the same vpc"
  vpc_id      = module.vpc.vpc_id

  tags = merge(
    { "Name" = "allow-all-same-vpc:sg" },
    var.tags
  )
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_from_same_vpc" {
  security_group_id            = aws_security_group.allow_all_same_vpc.id
  referenced_security_group_id = aws_security_group.allow_all_same_vpc.id
  ip_protocol                  = -1

  tags = merge(
    { "Name" = "allow-all-from-same-vpc:sg_ir" },
    var.tags
  )
}

resource "aws_vpc_security_group_egress_rule" "allow_all_to_same_vpc" {
  security_group_id            = aws_security_group.allow_all_same_vpc.id
  referenced_security_group_id = aws_security_group.allow_all_same_vpc.id
  ip_protocol                  = -1

  tags = merge(
    { "Name" = "allow-all-to-same-vpc:sg_er" },
    var.tags
  )
}
