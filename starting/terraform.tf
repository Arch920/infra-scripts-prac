terraform {
    backend "s3" {
        bucket  = "myrandom-terraform-demo-bucket"
        key     = "tf-course/terraform.tfstate"
        region  = "us-east-1"
        profile = "archit-personal"
        dynamodb_table = "terraform-state-lock-table"
    }
}