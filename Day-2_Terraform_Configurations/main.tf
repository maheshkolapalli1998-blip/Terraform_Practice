resource "aws_vpc" "my_vpc" {
    cidr_block = var.cidr_block
    tags = var.tags
}

resource "aws_vpc" "Dev" {
    cidr_block = var.cidr_block
    tags = var.tags
}


resource "aws_subnet" "my_subnet" {
    vpc_id = aws_vpc.Dev.id
    cidr_block = var.subnet_cidr_block
    tags = var.subnet_tags
}
