module "dev" {
  source        = "../Day-9_Modules"
  ami           = "ami-002eb20eceab2c0ad"
  instance_type = "t2.nano"
  tags = {
    Name = "dev-instance"
  }
}

