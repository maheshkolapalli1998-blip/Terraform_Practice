resource "aws_s3_bucket" "name" {
  bucket = "myapphellosystem"
}

resource "aws_s3_bucket_versioning" "name" {
  bucket = aws_s3_bucket.name.id
  versioning_configuration {
    status = "Enabled"
  }
}

#importing existing resources
#terraform import aws_s3_bucket.name myapphellosystem

#terraform import will import the existing resource into the state file, but it will not create the configuration in the .tf file. You will have to write the configuration manually in the .tf file to match the imported resource.