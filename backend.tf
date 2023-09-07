terraform {
  backend "s3" {
    bucket = "cloud-ai-jeremy-wang"
    key    = "cloud-ai/terraform.tfstate"
    region = "us-east-1"
  }
}