provider "aws" {
  version = "~> 3.0"
}

terraform {
  backend "s3" {
    bucket = "cloud-ai-demo-infra"
    key    = "cloud-ai/terraform.tfstate"
    region = "us-east-1"
  }
}