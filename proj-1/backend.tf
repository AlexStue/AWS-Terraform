# project/backend.tf

terraform {
  backend "s3" {
    bucket = "alexstue-terraform-state"
    key     = "proj-1/terraform.tfstate"
    region  = "eu-central-1"
    //dynamodb_table = "your-lock-table"
    //encrypt = true
  }
}
