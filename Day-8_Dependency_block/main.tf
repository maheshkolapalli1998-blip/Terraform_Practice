resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_s3_bucket" "lambda_bucket_mahesh_2026" {
  bucket = "lambda-bucket-mahesh-2026"

  depends_on = [aws_vpc.name]
}


#depends_on is used to explicitly specify dependencies between resources in Terraform. It ensures that the specified resource(s) are created before the dependent resource is created. In this case, the S3 bucket "lambda_bucket_mahesh_2026" depends on the VPC "name" being created first.