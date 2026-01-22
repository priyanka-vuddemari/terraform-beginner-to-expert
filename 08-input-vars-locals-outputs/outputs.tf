# command to output the S3 bucket name using raw - terraform output -raw s3_bucket_name
# coomand to output the S3 bucket name with the double quotes - terraform output s3_bucket_name
# command to output the S3 bucket name using json - terraform output -json s3_bucket_name

output "s3_bucket_name" {
  value = aws_s3_bucket.static_website.bucket
  # this below description will show up when you run terraform output --help
  # but not when you run terraform output s3_bucket_name or when terraform apply is done
  description = "The name of the S3 bucket for static website hosting"

  # by default outputs are not marked sensitive. When used with sensitive values like passwords, secrets, etc
  # for example in terminal you see like : s3_bucket_name = <sensitive>
  # but can be accessed using terraform output s3_bucket_name or terraform output -json
  sensitive = true
}