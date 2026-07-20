
resource "aws_instance" "mahi" {
  ami           = var.ami
  instance_type = var.instance_type
  tags          = var.tags
}
