# AWS Configuration Variables
variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use"
  type        = string
  default     = "archit-personal"
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/24"
}

variable "vpc_name" {
  description = "Name tag for VPC"
  type        = string
  default     = "main"
}

# Subnet Configuration
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.0.0/27", "10.0.0.32/27", "10.0.0.64/27"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.0.128/26", "10.0.0.192/26", "10.0.0.96/27"]
}

# Tags
variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}
