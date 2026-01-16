# a resource creates something while data source reads something

resource "aws_instance" "tf-ec2-renamed-jan10" {
  ami = data.aws_ami.ubuntu.id
  // instance_type = var.ec2_instance_type # for single ec2 type
  instance_type = var.ec2_instance_type["default"] # for multiple ec2 type

  subnet_id = module.vpc.public_subnets[0] # Correct attribute name for first public subnet

  vpc_security_group_ids = [aws_security_group.allow_all_sg.id]

  key_name = "tf-created-key"

  user_data = templatefile("${path.module}/../web.tpl", {"region" = var.aws_region})

  tags = {
    Name       = local.instance_name
    User       = "AB"
    CreatedVia = "terraform"
  }
}

resource "aws_security_group" "allow_all_sg" {
    name        = "allow_all_test_sg"
    description = "Allow all inbound traffic and all outbound traffic"
    vpc_id      = module.vpc.vpc_id

    ingress {
      from_port        = 0
      to_port          = 0
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
      Name       = "allow_all_test_sg"
      User       = "AB"
      CreatedVia = "terraform"
    }
  }

  resource "aws_key_pair" "tf-created-key" {
  key_name   = "tf-created-key"
  public_key = file("${path.module}/../tf-created-key.pub")
}