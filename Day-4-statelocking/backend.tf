terraform {
  backend "s3" {
    bucket = "mysecondbucketesssess"
    key    = "path/to/my/key"
    region = "us-east-1"
    use_lockfile = true
  }
}


