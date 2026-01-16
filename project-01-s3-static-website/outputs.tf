output "static_website_endpoint" {
  description = "The URL of the static website hosted on S3"
  value       = aws_s3_bucket.static-website.website_endpoint
}