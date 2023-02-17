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
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "demo" {
  ami           = "ami-0caf778a172362f1c"
  instance_type = "t2.micro"
  associate_public_ip_address = true

  tags = {
    Name = "terraform-hands-on"
  }
}
