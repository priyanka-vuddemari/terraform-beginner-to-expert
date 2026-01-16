resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "aws_s3_bucket" "static-website" {
  bucket = "terraform-static-website-${random_id.bucket_id.hex}"
}

resource "aws_s3_bucket_public_access_block" "disable_public_access" {
  bucket                  = aws_s3_bucket.static-website.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.static-website.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static-website.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "static_website_config" {
  bucket = aws_s3_bucket.static-website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}


resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.static-website.id
  key          = "index.html"
  source       = "${path.module}/build/index.html"
  etag         = filemd5("${path.module}/build/index.html")
  content_type = "text/html"
}

resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.static-website.id
  key          = "error.html"
  source       = "${path.module}/build/error.html"
  etag         = filemd5("${path.module}/build/error.html")
  content_type = "text/html"
}