terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAXA6BXUMTYQJELO4M"
  secret_key = "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"
}

resource "aws_instance" "demo" {
  ami           = "ami-0caf778a172362f1c"
  instance_type = "t2.micro"
  associate_public_ip_address = true

  tags = {
    Name = "terraform-hands-on"
  }
}
