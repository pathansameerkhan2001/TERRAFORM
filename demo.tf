provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAXA6BXUMT7KCRUW7Z"
  secret_key = "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"
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
  vpc_id = "vpc-06a02ecff9b4b756a"

  tags = {
    Name = "demo-gateway"
  }
}

#custom route table 

resource "aws_route_table" "sample-route-table" {
  vpc_id = "vpc-06a02ecff9b4b756a"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-03617183a0138ee06"
  }

  tags = {
    Name = "sample-route-table"
  }
}



#creating the Subnet 

resource "aws_subnet" "new-subnet" {
  vpc_id     = "vpc-06a02ecff9b4b756a"
  cidr_block = "10.0.1.0/24"     

  tags = {
    Name = "new-subnet"
  }
}

#Associting the Subnet with the Route Table

resource "aws_route_table_association" "new-srt" {
  subnet_id      = "subnet-09def1f32d6d5c124"
  route_table_id = "rtb-01970ef70dcf9d752"
}

#creating new security group

resource "aws_security_group" "demo_sg" {
  name_prefix = "demo_sg"
  vpc_id      = "vpc-06a02ecff9b4b756a"

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
  subnet_id       = "subnet-09def1f32d6d5c124"
  private_ips     = ["10.0.1.10"]
  security_groups = ["sg-0c32db1d22a95ecf0"]

  tags = {
    Name = "demo_network"
  }
}

#creating elastic_ip

resource "aws_eip" "new_eip" {
  vpc = true
}

resource "aws_eip_association" "new_eip" {
  network_interface_id = "eni-00cbfd25dd91e30b3"
  allocation_id        = "eipalloc-08c83d1bba95d4a17"
}

#creating aws instance

resource "aws_instance" "demo" {
  ami           = "ami-0caf778a172362f1c"
  instance_type = "t2.micro"
  key_name = "sameer123"
  vpc_security_group_ids = ["sg-0c32db1d22a95ecf0"]
  subnet_id = "subnet-09def1f32d6d5c124"
  associate_public_ip_address = true

  tags = {
    Name = "demo.tf"
  }
}
