# ============================================
# Security Group for SSH Access
# ============================================

# Security group allowing SSH access from specific IP ranges
resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow-ssh-"
  description = "Security group that allows SSH and all egress traffic"
  vpc_id      = aws_vpc.main.id

  # Outbound traffic - allow all
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound SSH - restrict to your IP for security
  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr] # Replace 0.0.0.0/0 with your IP
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-allow-ssh"
    }
  )
}