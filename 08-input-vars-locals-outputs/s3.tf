resource "random_id" "bucket_suffix" {
  byte_length = 4

}
resource "aws_s3_bucket" "static_website" {
  bucket = "${local.project}-${random_id.bucket_suffix.hex}"

  tags = merge(
    local.common_tags, var.addtional_tags
  )
}

