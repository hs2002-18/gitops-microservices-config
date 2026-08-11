terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
  bucket         = "gitops-microservices-config-s3-bucket"
  key            = "gitops-microservices/prod/terraform.tfstate"
  region         = "ap-south-1"
  dynamodb_table = "terraform-state-lock"
  encrypt        = true
}
}

provider "aws" {
  region = var.aws_region
}

module "aws_infrastructure" {
  source = "../../modules/aws-infrastructure"

  environment      = var.environment
  instance_type    = var.instance_type
  ami_id           = var.ami_id
  key_name         = var.key_name
  allowed_ssh_cidr = var.allowed_ssh_cidr
}