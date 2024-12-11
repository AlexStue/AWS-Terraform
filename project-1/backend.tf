terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "state.tfstate"
    region = "eu-central-1"
  }
}
