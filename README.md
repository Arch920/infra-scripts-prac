# Terraform Practice Repository

A collection of Terraform configurations for learning and practicing AWS infrastructure automation. This repository demonstrates progressive complexity from basic EC2 instances to complete VPC setups with NAT gateways and advanced configurations.

## 📁 Repository Structure

### 🚀 Basic Configurations
- **`starting/`** - Foundational Terraform setup with EC2, VPC module, and basic security groups
- **`datasource/`** - Examples of using Terraform data sources to fetch AWS resources

### 🔍 Advanced Data Sources
- **`ec2-type-support-check/`** - Validates EC2 instance type availability across AWS availability zones

### 🌐 VPC Configurations
- **`vpc-with-nat/`** - Basic VPC setup with NAT gateway for private subnet internet access
- **`vpc-with-nat-ec2/`** - VPC with NAT gateway plus EC2 instances in both public and private subnets
- **`vpc-with-nat-ec2-ebs/`** - Complete setup including EBS volumes attached to EC2 instances

### ☁️ Cloud-Init Integration
- **`ec2-with-nat-userdata/`** - Advanced EC2 deployment using cloud-init for automated instance configuration

## 🛠️ Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- AWS CLI configured with appropriate credentials
- AWS account with necessary permissions for EC2, VPC, and related services

## 🚀 Quick Start

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd TFScripts
   ```

2. Navigate to any practice folder:
   ```bash
   cd starting/
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Plan your deployment:
   ```bash
   terraform plan
   ```

5. Apply the configuration:
   ```bash
   terraform apply -auto-approve
   ```

## 🔧 Common Resources Used

- AWS VPC with public/private subnets
- EC2 instances with security groups
- NAT gateways for private subnet internet access
- Internet gateways for public subnet connectivity
- EBS volumes for additional storage
- SSH key pairs for secure access

## 🧹 Cleanup

Always remember to destroy resources when done practicing:

```bash
terraform destroy -auto-approve
```
