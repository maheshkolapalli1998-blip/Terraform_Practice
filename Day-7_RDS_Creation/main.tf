resource "aws_vpc" "My_VPC" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
        Name = "My_VPC"
    }
}

resource "aws_subnet" "My_Db_Subnet_1" {
    vpc_id            = aws_vpc.My_VPC.id
    cidr_block        = "10.0.0.0/24"
    availability_zone = "us-west-1a"
    tags = {
        Name = "My_Db_Subnet_1"
    }

}
resource "aws_subnet" "My_Db_Subnet_2" {
    vpc_id            = aws_vpc.My_VPC.id
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-west-1c"
    tags = {
        Name = "My_Db_Subnet_2"
    }

} 

resource "aws_internet_gateway" "My_IGW" {
    vpc_id = aws_vpc.My_VPC.id
    tags = {
        Name = "My_IGW"
    }
}

resource "aws_route_table" "My_Route_Table" {
    vpc_id = aws_vpc.My_VPC.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.My_IGW.id
    }
}

resource "aws_route_table_association" "My_Route_Table_Association_1" {
    subnet_id      = aws_subnet.My_Db_Subnet_1.id
    route_table_id = aws_route_table.My_Route_Table.id
}

resource "aws_route_table_association" "My_Route_Table_Association_2" {
    subnet_id      = aws_subnet.My_Db_Subnet_2.id
    route_table_id = aws_route_table.My_Route_Table.id
}

resource "aws_security_group" "My_SG" {
    name        = "My_SG"
    description = "Security group for My environment"
    vpc_id      = aws_vpc.My_VPC.id

    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
}

resource "aws_db_subnet_group" "My_DB_Subnet_Group" {
    name       = "my-db-subnet-group"
    subnet_ids = [aws_subnet.My_Db_Subnet_1.id, aws_subnet.My_Db_Subnet_2.id]
    tags = {
        Name = "My-DB-Subnet-Group"
    }
}

resource "aws_db_instance" "My_DB_Instance" {
    allocated_storage      = 20
    engine                 = "mysql"
    engine_version         = "5.7"
    instance_class         = "db.t3.micro"
    identifier             = "mydatabase"
    username               = "admin"
    password               = "Mahesh123"
    parameter_group_name   = "default.mysql5.7"
    publicly_accessible    = true
    skip_final_snapshot    = true
    vpc_security_group_ids = [aws_security_group.My_SG.id]
    db_subnet_group_name   = aws_db_subnet_group.My_DB_Subnet_Group.name

    backup_retention_period = 7 
}

resource "aws_db_instance" "My_DB_Replica" {
    count                  = 1
    replicate_source_db    = aws_db_instance.My_DB_Instance.arn
    instance_class         = "db.t3.micro"
    publicly_accessible    = true
    db_subnet_group_name   = aws_db_subnet_group.My_DB_Subnet_Group.name
    vpc_security_group_ids = [aws_security_group.My_SG.id]

    backup_retention_period = 7

}
