# ============================================
# SSH Key Pair Configuration
# ============================================

# SSH key pair for EC2 instance access
resource "aws_key_pair" "mykeypair" {
  key_name   = "${var.vpc_name}-keypair"
  public_key = file(var.PATH_TO_PUBLIC_KEY)

  tags = merge(
    var.common_tags,
    {
      Name = "${var.vpc_name}-keypair"
    }
  )
}