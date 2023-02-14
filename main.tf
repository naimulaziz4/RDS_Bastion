terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider 
provider "aws" {
  region = "us-east-1"
}

#OPTIONAL COMPLETE
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  depends_on = [aws_vpc.main]

  tags = {
    Name = "public"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  depends_on = [aws_vpc.main]

  tags = {
    Name = "igw"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  depends_on = [aws_vpc.main]

  tags = {
    Name = "private"
  }
}
# flow log file format required for snow sql

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public"
  }

  depends_on = [aws_vpc.main]
}

resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private"
  }

  depends_on = [aws_vpc.main]
}

resource "aws_security_group" "main_sg" {
  name        = "allow_tls"
  description = "Allow TLS Inbound"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "sg-main"
  }

  depends_on = [aws_vpc.main]
}