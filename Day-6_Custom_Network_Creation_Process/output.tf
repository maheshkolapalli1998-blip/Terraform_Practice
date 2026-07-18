output "private_ip" {
    value = try(aws_instance.Dev_Instance[0].private_ip, null)
}

output "public_ip" {
    value = try(aws_instance.Dev_Instance[0].public_ip, null)
}

output "instance_id" {
    value = try(aws_instance.Dev_Instance[0].id, null)
}

output "instance_arn" {
    value = try(aws_instance.Dev_Instance[0].arn, null)
}

output "vpc_id" {
    value = aws_vpc.Dev_VPC.id
}

output "subnet_id" {
    value = try(aws_instance.Dev_Instance[0].subnet_id, null)
}

output "availability_zone" {
    value = try(aws_instance.Dev_Instance[0].availability_zone, null)
}

output "instance_state" {
    value = try(aws_instance.Dev_Instance[0].instance_state, null)
}