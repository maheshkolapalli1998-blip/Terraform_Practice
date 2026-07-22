resource "aws_instance" "Dev_Instance_2" {
    ami = "02eb20eceab2c0ad1"
    instance_type = "t2.medium"

    tags = {
        Name = "Dev-2"
    }

    lifecycle {
        prevent_destroy = true
        create_before_destroy = true
        ignore_changes = [ami, instance_type]
    }
}

#lifecycle rules are used to control the behavior of resources in Terraform. In this case, the prevent_destroy rule is set to true, which means that if someone tries to destroy this resource, Terraform will prevent it from being destroyed. This can be useful for critical resources that should not be accidentally deleted.
#igniore_changes rule is set to [ami, instance_type], which means that if the ami or instance_type attributes of this resource are changed, Terraform will ignore those changes and not attempt to update the resource. This can be useful for resources that should not be updated automatically, such as instances that are running critical workloads.
# create_before_destroy rule is set to true, which means that if this resource needs to be replaced (for example, if the ami or instance_type attributes are changed), Terraform will create a new instance before destroying the old one. This can be useful for resources that need to be replaced without downtime, such as instances that are running critical workloads.