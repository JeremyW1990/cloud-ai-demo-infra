provider "aws" {
  version = "~> 3.0"
}

# required_providers {
#   aws = {
#    source = "hashicorp/aws"
#   }
# }

terraform {
  backend "s3" {
    bucket = "cloud-ai-demo-infra"
    key    = "cloud-ai/terraform.tfstate"
    region = "us-east-1"
  }
}
