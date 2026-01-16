variable "ec2_instance_type" {
  type = map(any) #to allow multiple types of ec2 instances
  default = {
    "example" = "t3.micro"
  }
}

//variable "ec2_instance_type" {
//  type    = string #to allow single type of ec2 instances
//  default = "t2.micro"
//}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}