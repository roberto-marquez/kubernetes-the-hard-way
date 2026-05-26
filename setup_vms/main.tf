# -- Network --
module "vpc" {
  source = "./vpc"

  name       = "k8s-vpc"
  aws_region = var.aws_region
  azs        = var.azs
  cidr       = var.cidr

  # Public Subnet
  public_subnets                    = var.public_subnets
  assign_public_ip_on_public_subnet = true
  known_ips                         = var.known_ips

  # Private Subnet
  private_subnets = var.private_subnets

  # Tags
  tags = var.tags
}

# -- AMI --
data "aws_ami" "debian12" {
  # Debian GNU/Linux
  most_recent = true
  owners      = ["136693071363"]

  filter {
    name   = "name"
    values = ["debian-12-arm64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# -- SSH Key --
resource "aws_key_pair" "dev" {
  key_name   = "dev"
  public_key = var.public_key
}

# -- EC2s --
module "jumpbox" {
  source = "terraform-aws-modules/ec2-instance/aws"

  # | Name    | Description            | CPU | RAM   | Storage |
  # |---------|------------------------|-----|-------|---------|
  # | jumpbox | Administration host    | 1   | 512MB | 10GB    |

  name = "jumpbox"

  # OS
  ami = data.aws_ami.debian12.id

  # Type/Size
  instance_type = "t4g.nano"
  # create_spot_instance                = true
  # spot_instance_interruption_behavior = "terminate"
  # spot_type                           = "one-time"

  # Networking
  create_eip             = false # the public subnet is configured to automatically map public ips to instances in it
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = module.vpc.security_group_ids
  private_ip             = local.private_ips.jumpbox
  user_data = templatefile("./files/user_data.sh.tftpl", {
    hostname   = "jumpbox"
    hosts_file = local.hosts_file
  })

  # Storage
  root_block_device = {
    delete_on_termination = true
    size                  = 10
  }

  # SSH
  key_name = aws_key_pair.dev.key_name

  # Misc
  monitoring = false
  tags       = var.tags
}

module "server" {
  source = "terraform-aws-modules/ec2-instance/aws"

  # | Name    | Description            | CPU | RAM   | Storage |
  # |---------|------------------------|-----|-------|---------|
  # | server  | Kubernetes server      | 1   | 2GB   | 20GB    |

  name = "server"

  # OS
  ami = data.aws_ami.debian12.id

  # Type/Size
  instance_type = "t4g.small"
  # create_spot_instance                = true
  # spot_instance_interruption_behavior = "terminate"
  # spot_type                           = "one-time"

  # Networking
  create_eip             = false
  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = module.vpc.security_group_ids
  private_ip             = local.private_ips.server
  user_data = templatefile("./files/user_data.sh.tftpl", {
    hostname   = "server"
    hosts_file = local.hosts_file
  })

  # Storage
  root_block_device = {
    delete_on_termination = true
    size                  = 20
  }

  # SSH
  key_name = aws_key_pair.dev.key_name

  # Misc
  monitoring = false
  tags       = var.tags
}

module "node0" {
  source = "terraform-aws-modules/ec2-instance/aws"

  # | Name    | Description            | CPU | RAM   | Storage |
  # |---------|------------------------|-----|-------|---------|
  # | node-0  | Kubernetes worker node | 1   | 2GB   | 20GB    |

  name = "node0"

  # OS
  ami = data.aws_ami.debian12.id

  # Type/Size
  instance_type = "t4g.small"
  # create_spot_instance                = true
  # spot_instance_interruption_behavior = "terminate"
  # spot_type                           = "one-time"

  # Networking
  create_eip             = false
  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = module.vpc.security_group_ids
  private_ip             = local.private_ips.node0
  user_data = templatefile("./files/user_data.sh.tftpl", {
    hostname   = "node0"
    hosts_file = local.hosts_file
  })

  # Storage
  root_block_device = {
    delete_on_termination = true
    size                  = 20
  }

  # SSH
  key_name = aws_key_pair.dev.key_name

  # Misc
  monitoring = false
  tags       = var.tags
}

module "node1" {
  source = "terraform-aws-modules/ec2-instance/aws"

  # | Name    | Description            | CPU | RAM   | Storage |
  # |---------|------------------------|-----|-------|---------|
  # | node-1  | Kubernetes worker node | 1   | 2GB   | 20GB    |

  name = "node1"

  # OS
  ami = data.aws_ami.debian12.id

  # Type/Size
  instance_type = "t4g.small"
  # create_spot_instance                = true
  # spot_instance_interruption_behavior = "terminate"
  # spot_type                           = "one-time"

  # Networking
  create_eip             = false
  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = module.vpc.security_group_ids
  private_ip             = local.private_ips.node1
  user_data = templatefile("./files/user_data.sh.tftpl", {
    hostname   = "node1"
    hosts_file = local.hosts_file
  })

  # Storage
  root_block_device = {
    delete_on_termination = true
    size                  = 20
  }

  # SSH
  key_name = aws_key_pair.dev.key_name

  # Misc
  monitoring = false
  tags       = var.tags
}
