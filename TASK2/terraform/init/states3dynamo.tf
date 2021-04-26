provider "aws" {
  region = "ap-southeast-1"
}
resource "aws_s3_bucket" "terraform_state" {
  bucket = "tfstate-web-application"
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "tfstate-web-application"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}