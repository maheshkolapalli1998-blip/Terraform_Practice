resource "aws_instance" "name" {
    ami = "ami-002eb20eceab2c0ad"
    instance_type = "t2.micro"
    tags = {
        Name = "Hello"
    }

