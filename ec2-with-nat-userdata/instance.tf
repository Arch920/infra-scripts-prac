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

  # User data for initialization
  user_data = data.cloudinit_config.cloudinit-example.rendered

  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-ec2-example"
    }
  )
}

# Attach EBS volume to instance
resource "aws_ebs_volume" "extra-ebs-1" {
  availability_zone = aws_subnet.public[0].availability_zone
  size              = 10
  type              = "gp3"
  
  # Uncomment below line to enable encryption with AWS managed key
  # encrypted = true
  
  tags = merge(
    var.common_tags,
    {
      Name = "extra-ebs-1"
    }
  )
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name                    = var.INSTANCE_DEVICE_NAME
  volume_id                      = aws_ebs_volume.extra-ebs-1.id
  instance_id                    = aws_instance.example.id
  stop_instance_before_detaching = true
}