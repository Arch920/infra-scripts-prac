locals {
  # CHANGED: Added dynamic naming for all VPC resources
  instance_name = "tf-ec2-${formatdate("MMM-DD", timestamp())}"
  vpc_name      = "tf-vpc-${formatdate("MMM-DD", timestamp())}"
  igw_name      = "tf-igw-${formatdate("MMM-DD", timestamp())}"
  nat_gw_name   = "tf-nat-gw-${formatdate("MMM-DD", timestamp())}"

  # Dynamic subnet names with AZ suffix
  subnet_name_prefix = "tf-subnet-${formatdate("MMM-DD", timestamp())}"

  # Dynamic route table names
  public_rt_name  = "tf-public-rt-${formatdate("MMM-DD", timestamp())}"
  private_rt_name = "tf-private-rt-${formatdate("MMM-DD", timestamp())}"
}