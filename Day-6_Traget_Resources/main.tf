resource "aws_vpc" "Dev_VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Dev-VPC"
  }
}

resource "aws_subnet" "Dev_Subnet" {
  vpc_id            = aws_vpc.Dev_VPC.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Dev-Subnet"
  }
}

# Terraform target command is used to apply changes to specific resources in a Terraform configuration. It allows you to focus on a subset of resources rather than applying changes to the entire configuration.