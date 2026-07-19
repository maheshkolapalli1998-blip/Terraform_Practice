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

resource "aws_subnet" "Dev_Subnet_2" {
  vpc_id            = aws_vpc.Dev_VPC.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Dev-Subnet-2"
  }
}

resource "aws_internet_gateway" "DEV_VPC" {
  vpc_id = aws_vpc.Dev_VPC.id
  tags = {
    Name = "Dev-IGW"
  }
}

resource "aws_route_table" "Dev_Route_Table" {
  vpc_id = aws_vpc.Dev_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.DEV_VPC.id
  }

  tags = {
    Name = "Dev-Route-Table"
  }
}

resource "aws_route_table_association" "Dev_Route_Table_Association" {
  subnet_id      = aws_subnet.Dev_Subnet.id
  route_table_id = aws_route_table.Dev_Route_Table.id
}

resource "aws_route_table_association" "Dev_Route_Table_Association_2" {
  subnet_id      = aws_subnet.Dev_Subnet_2.id
  route_table_id = aws_route_table.Dev_Route_Table.id
}

resource "aws_security_group" "Dev_SG" {
  name        = "Dev-SG"
  description = "Security group for Dev environment"
  vpc_id      = aws_vpc.Dev_VPC.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "Dev_Instance" {
  count                      = 0
  ami                        = "ami-06067086cf86c58e6"
  instance_type              = "t2.micro"
  subnet_id                  = aws_subnet.Dev_Subnet.id
  vpc_security_group_ids     = [aws_security_group.Dev_SG.id]
  associate_public_ip_address = true
  tags = {
    Name = "Dev-Instance"
  }
}

resource "aws_db_subnet_group" "Dev_DB_Subnet_Group" {
  name       = "dev-db-subnet-group"
  subnet_ids = [aws_subnet.Dev_Subnet.id, aws_subnet.Dev_Subnet_2.id]

  tags = {
    Name = "Dev-DB-Subnet-Group"
  }
}

resource "aws_db_instance" "Dev_RDS" {
  count                  = 1
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  identifier             = "devdb"
  username               = "admin"
  password               = "password"
  parameter_group_name   = "default.mysql5.7"
  publicly_accessible    = true
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.Dev_SG.id]
  db_subnet_group_name   = aws_db_subnet_group.Dev_DB_Subnet_Group.name

  tags = {
    Name = "Dev-RDS"
  }
}

resource "aws_subnet" "Dev_Private_Subnet" {
  vpc_id                  = aws_vpc.Dev_VPC.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"
  tags = {
    Name = "Dev Private Subnet"
  }
}



resource "aws_eip" "Dev_EIP" {
  tags = {
    Name = "Dev EIP"
  }
}

resource "aws_nat_gateway" "Dev_NAT_Gateway" {
  allocation_id = aws_eip.Dev_EIP.id
  subnet_id     = aws_subnet.Dev_Subnet.id
  tags = {
    Name = "Dev NAT Gateway"
  }
}



resource "aws_route_table" "Dev_Private_Route_Table" {
  vpc_id = aws_vpc.Dev_VPC.id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.Dev_NAT_Gateway.id
  }
}

resource "aws_route_table_association" "Dev_Private_Route_Table_Association" {
  subnet_id      = aws_subnet.Dev_Private_Subnet.id
  route_table_id = aws_route_table.Dev_Private_Route_Table.id
}
