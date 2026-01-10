module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.vpc_name
  cidr = "10.0.0.0/24"  #  /24 provides 256 IPs (10.0.0.0 - 10.0.0.255)

  azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets = ["10.0.0.0/26", "10.0.0.64/26"]    #  /26 subnets within VPC range (64 IPs each)
  public_subnets  = ["10.0.0.128/28", "10.0.0.144/28"]  #  /28 subnets within VPC range (16 IPs each)

  map_public_ip_on_launch = true
  
  enable_nat_gateway = false
  enable_vpn_gateway = false

  # CHANGED: Added dynamic tags for all VPC resources
  tags = {
    Name       = local.vpc_name
    User       = "AB"
    CreatedVia = "terraform"
  }

  # CHANGED: Added dynamic tags for subnets
  public_subnet_tags = {
    Name       = "${local.subnet_name_prefix}-public"
    User       = "AB"
    CreatedVia = "terraform"
  }

  private_subnet_tags = {
    Name       = "${local.subnet_name_prefix}-private"
    User       = "AB"
    CreatedVia = "terraform"
  }

  # CHANGED: Added dynamic tags for IGW
  igw_tags = {
    Name       = local.igw_name
    User       = "AB"
    CreatedVia = "terraform"
  }

  # CHANGED: Added dynamic tags for route tables
  public_route_table_tags = {
    Name       = local.public_rt_name
    User       = "AB"
    CreatedVia = "terraform"
  }

  private_route_table_tags = {
    Name       = local.private_rt_name
    User       = "AB"
    CreatedVia = "terraform"
  }
}