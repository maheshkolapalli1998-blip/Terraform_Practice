resource "aws_instance" "Dev_Instance_2" {
    ami = "02eb20eceab2c0ad1"
    instance_type = "t2.medium"
    tags = {
        Name = "Dev-2"
    }

    #lifecycle {
        #create_before_destroy = true
        #ignore_changes = [
           # tags["Name"],
        #]
    #}
#}

    lifecycle {
    prevent_destroy = true
}