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

#creating vpc 

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my-vpc"
  }
}

#creating internet gate way

resource "aws_internet_gateway" "demo-gateway" {
  vpc_id = ""

  tags = {
    Name = "demo-gateway"
  }
}

#custom route table 

resource "aws_route_table" "sample-route-table" {
  vpc_id = ""

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = ""
  }

  tags = {
    Name = "sample-route-table"
  }
}



#creating the Subnet 

resource "aws_subnet" "new-subnet" {
  vpc_id     = ""
  cidr_block = "10.0.1.0/24"     

  tags = {
    Name = "new-subnet"
  }
}

#Associting the Subnet with the Route Table

resource "aws_route_table_association" "new-srt" {
  subnet_id      = ""
  route_table_id = ""
}

#creating new security group

resource "aws_security_group" "demo_sg" {
  name_prefix = "demo_sg"
  vpc_id      = ""

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo_sg"
  }
}

#creating network_interface  

resource "aws_network_interface" "demo_network" {
  subnet_id       = ""
  private_ips     = ["10.0.1.10"]
  security_groups = [""]

  tags = {
    Name = "demo_network"
  }
}

#creating elastic_ip

resource "aws_eip" "new_eip" {
  vpc = true
}

resource "aws_eip_association" "new_eip" {
  network_interface_id = ""
  allocation_id        = ""
}

#creating aws instance

resource "aws_instance" "demo" {
  ami           = ""
  instance_type = "t2.micro"
  key_name = ""
  vpc_security_group_ids = [""]
  subnet_id = ""
  associate_public_ip_address = true

  tags = {
    Name = "demo.tf"
  }
}
