resource "aws_instance" "tf-ec2-renamed-jan10" {
  ami = data.aws_ami.ubuntu.id
  // instance_type = var.ec2_instance_type # for single ec2 type
  instance_type = var.ec2_instance_type["default"] # for multiple ec2 type

  subnet_id = module.vpc.public_subnets[0]  # Correct attribute name for first public subnet

  tags = {
    Name       = local.instance_name
    User       = "AB"
    CreatedVia = "terraform"
  }
}