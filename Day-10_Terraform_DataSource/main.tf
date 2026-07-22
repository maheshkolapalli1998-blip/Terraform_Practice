data "aws_subnet" "name" {
    filter {
        name   = "tag:Name"
        values = ["DB-subnet"]
    }
  
}
data "aws_vpc" "name" {
    filter {
        name   = "tag:Name"
        values = ["main-vpc"]
    }
  
}

data "aws_security_group" "name" {
    filter {
        name   = "tag:Name"
        values = ["web-sg"]
    }
  
}




resource "aws_instance" "name" {
    ami = "ami-002eb20eceab2c0ad"
    instance_type = "t2.small"
    tags = {
        Name = "Mahi"
    }
    subnet_id = data.aws_subnet.name.id
    security_groups = [data.aws_security_group.name.name]

  
}

