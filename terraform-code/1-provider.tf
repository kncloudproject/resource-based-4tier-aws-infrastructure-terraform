provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 1.1.7"
  backend "s3" {
    bucket = "kn-pbl-terraform-statefile-masterclass"
    # key          = "<Env>/s3/terraform.tfstate" # Replace <Env> with an actual environment name, like "dev", "prod", or "staging"
    key            = "dev/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "kn-pbl-terraform-locks-masterclass"
    encrypt        = true
  }
}
