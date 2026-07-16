terraform {
  backend "s3" {
    bucket = "mysecondbucketesssess"
    key    = "path/to/my/key"
    region = "us-east-1"
    use_lockfile = true #supports state locking only below versions of terraform 0.9.0 and above
    dynamodb_table = "my-second-lock-table" #supports state locking only below versions of terraform 0.9.0 and above}
}


