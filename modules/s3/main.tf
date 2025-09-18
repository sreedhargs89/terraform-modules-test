resource "random_id" "bucket_suffix" {
  byte_length = 3
}

resource "aws_s3_bucket" "this" {
  bucket = "${var.tag_prefix}-${terraform.workspace}-terraform-test-bucket-${random_id.bucket_suffix.hex}"

  tags = {
    Name = "${var.tag_prefix}-${terraform.workspace}-S3"
  }
}
