# AWS Provider Configuration
# Uses variables for region and profile to support multiple environments
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}