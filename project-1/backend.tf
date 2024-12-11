# project/backend.tf

terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key     = "project/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
