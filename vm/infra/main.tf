terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.53"
    }
  }
}

provider "aws" {
  region                  = "us-east-2"
  shared_credentials_file = "/home/matheus/.aws/credentials"
}

terraform {
  backend "s3" {
    bucket = "descomplicando-gitlab"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}