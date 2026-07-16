resource "aws_s3_bucket" "tfstate" {
  bucket = "mahesh123456-terraform-state"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "terraform-state-bucket"
    Environment = "dev"
  }
}
