resource "aws_instance" "name" {
    ami = "ami-002eb20eceab2c0ad"
    instance_type = "t2.micro"
    tags = {
        Name = "Hello"
    }
}



resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my_vpc"
    }
}
