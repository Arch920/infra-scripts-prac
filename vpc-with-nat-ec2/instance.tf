# ============================================
# EC2 Instance Configuration
# ============================================

# EC2 instance in public subnet with SSH access
resource "aws_instance" "example" {
  ami           = var.AMIS[var.aws_region]
  instance_type = "t3.micro"

  # Place in first public subnet
  subnet_id = aws_subnet.public[0].id

  # Attach security group for SSH access
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  # SSH key for access
  key_name = aws_key_pair.mykeypair.key_name

  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-ec2-example"
    }
  )
}