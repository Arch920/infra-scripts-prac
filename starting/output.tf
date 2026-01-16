# CHANGED: Enhanced outputs for better debugging and understanding

# EC2 Instance Outputs
output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.tf-ec2-renamed-jan10.public_ip
}

output "private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.tf-ec2-renamed-jan10.private_ip
}

output "arn" {
  description = "ARN of the EC2 instance"
  value       = aws_instance.tf-ec2-renamed-jan10.arn
}

output "availability_zone" {
  description = "Availability zone of the EC2 instance"
  value       = aws_instance.tf-ec2-renamed-jan10.availability_zone
}

output "instance_state" {
  description = "State of the EC2 instance"
  value       = aws_instance.tf-ec2-renamed-jan10.instance_state
}

output "id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.tf-ec2-renamed-jan10.id
}

output "tags" {
  description = "Tags of the EC2 instance"
  value       = aws_instance.tf-ec2-renamed-jan10.tags
}

# VPC Outputs
output "vpc_name" {
  description = "Name of the VPC"
  value       = module.vpc.name
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_arn" {
  description = "ARN of the VPC"
  value       = module.vpc.vpc_arn
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

# Private Subnet Outputs
output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

output "private_subnets_cidr_blocks" {
  description = "List of private subnet CIDR blocks"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "private_subnets_arns" {
  description = "List of private subnet ARNs"
  value       = [for subnet in module.vpc.private_subnets : "arn:aws:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:subnet/${subnet}"]
}

# CHANGED: Added private subnet names and AZs for better debugging
output "private_subnet_names_and_azs" {
  description = "Map of private subnet IDs to their names and availability zones"
  value = {
    for i, subnet in module.vpc.private_subnets : subnet => {
      name = "${local.subnet_name_prefix}-private-${substr(module.vpc.azs[i], -2, 2)}"
      az   = module.vpc.azs[i]
    }
  }
}

# Public Subnet Outputs
output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

output "public_subnets_cidr_blocks" {
  description = "List of public subnet CIDR blocks"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "public_subnets_arns" {
  description = "List of public subnet ARNs"
  value       = [for subnet in module.vpc.public_subnets : "arn:aws:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:subnet/${subnet}"]
}

# CHANGED: Added public subnet names and AZs for better debugging
output "public_subnet_names_and_azs" {
  description = "Map of public subnet IDs to their names and availability zones"
  value = {
    for i, subnet in module.vpc.public_subnets : subnet => {
      name = "${local.subnet_name_prefix}-public-${substr(module.vpc.azs[i], -2, 2)}"
      az   = module.vpc.azs[i]
    }
  }
}

# Route Table Outputs
# CHANGED: Added route table outputs for better debugging
output "public_route_table_ids" {
  description = "List of public route table IDs"
  value       = module.vpc.public_route_table_ids
}

output "private_route_table_ids" {
  description = "List of private route table IDs"
  value       = module.vpc.private_route_table_ids
}

output "public_route_table_arns" {
  description = "List of public route table ARNs"
  value       = [for rt in module.vpc.public_route_table_ids : "arn:aws:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:route-table/${rt}"]
}

output "private_route_table_arns" {
  description = "List of private route table ARNs"
  value       = [for rt in module.vpc.private_route_table_ids : "arn:aws:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:route-table/${rt}"]
}

# IGW Outputs
output "igw_arn" {
  description = "ARN of the Internet Gateway"
  value       = module.vpc.igw_arn
}

output "igw_id" {
  description = "ID of the Internet Gateway"
  value       = module.vpc.igw_id
}

# CHANGED: Added region output for reference
output "aws_region" {
  description = "AWS region where resources are deployed"
  value       = var.aws_region
}
