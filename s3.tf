resource "aws_s3_bucket" "b" {
  bucket = "my-tf-testing-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
