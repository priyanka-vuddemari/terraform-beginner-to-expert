import {
  to = aws_lambda_function.this
  #   identity = {
  #     function_name = "create_lambda_fn"
  #   }
  id = "create_lambda_fn"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.root}/build/index.mjs"
  output_path = "${path.root}/lambda.zip"
}

resource "aws_lambda_function" "this" {
  architectures = ["x86_64"]
  description   = "A starter AWS Lambda function."
  filename      = "lambda.zip"
  function_name = "create_lambda_fn"
  handler       = "index.handler"
  # role             = "arn:aws:iam::987137005783:role/service-role/create_lambda_fn-role-cmtsciho"
  role             = aws_iam_role.lambda_execution_role.arn
  runtime          = "nodejs22.x"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  tags = {
    "lambda-console:blueprint" = "hello-world"
  }
  tags_all = {
    "lambda-console:blueprint" = "hello-world"
  }
  timeout = 3
  environment {
    variables = {}
  }
  logging_config {
    log_format = "Text"
    log_group  = "/aws/lambda/create_lambda_fn"
  }

}