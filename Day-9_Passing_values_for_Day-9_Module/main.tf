module "Dev" {
  source        = "../Day-9_Modules"
  ami           = var.ami
  instance_type = var.instance_type
  tags = var.tags
}

