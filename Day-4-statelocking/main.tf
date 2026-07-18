resource "aws_instance" "Dev_Instance_2" {
    ami = "02eb20eceab2c0ad"
    instance_type = "t2.medium"
    tags = {
        Name = "Dev-2"
    }
}
