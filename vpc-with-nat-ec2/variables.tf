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

# for Keys that are created & stored on machine (local/ laptop)
variable "PATH_TO_PRIVATE_KEY" {
  default = "../tf-created-key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "../tf-created-key.pub"
}

# option to choose AMI 
variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0c02fb55956c7d316" # Amazon Linux 2023
    us-west-2 = "ami-008fe2fc65df48dac" # Amazon Linux 2023
    eu-west-1 = "ami-01dd271720c1ba44f" # Amazon Linux 2023
  }
}

# SSH Access Configuration
variable "ssh_allowed_cidr" {
  description = "CIDR block allowed for SSH access (replace with your IP)"
  type        = string
  default     = "0.0.0.0/0" # CHANGE THIS to your IP/32 for security
}