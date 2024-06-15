provider "aws" {
  region  = "eu-west-2"
  profile = "lead"
}

resource "aws_s3_bucket" "s3b-team2" {
  bucket        = "kops-server-sockshop"
  force_destroy = true
  tags = {
    Name = "kops-server-sockshop"
  }
}

resource "aws_dynamodb_table" "db-state-team2" {
  name           = "kops-sockshop"
  hash_key       = "LockID"
  read_capacity  = "10"
  write_capacity = "10"
  attribute {
    name = "LockID"
    type = "S"
  }
}
