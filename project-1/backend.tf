terraform {
  backend "s3" {
    bucket = "alexstue-terraform-state-bucket"
    key    = "state.tfstate"
    region = "eu-central-1"
  }
}
