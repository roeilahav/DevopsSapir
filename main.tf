terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = "us-west-1"
  access_key = ""
  secret_key = ""

}
resource "aws_vpc" "RoeiLahav-Dev-vpc" {
  cidr_block       = "10.0.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "Roei-Lahav-dev-vpc"
  }
}

resource "aws_internet_gateway" "igw_Roei" {
    vpc_id = aws_vpc.RoeiLahav-Dev-vpc.id
     tags = {
    Name = "RoeiLahav-igw"
     }
  
}
resource "aws_route" "routeRL" {
  route_table_id         = aws_vpc.RoeiLahav-Dev-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_Roei.id
}
resource "aws_subnet" "RoeiLahav-k8s-subnet" {
  vpc_id = aws_vpc.RoeiLahav-Dev-vpc.id
  cidr_block = "10.0.0.0/27"
  availability_zone = "us-west-1a"
    tags = {
    Name = "RoeiLahav-k8s-subnet"
     }
}