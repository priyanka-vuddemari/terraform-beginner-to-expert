import {
  to = aws_iam_role.lambda_execution_role
  id = "create_lambda_fn-role-cmtsciho"
}




resource "aws_iam_role" "lambda_execution_role" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })



  #   description           = null
  #   force_detach_policies = false
  #   max_session_duration  = 3600
  #   name                  = "create_lambda_fn-role-cmtsciho"

  path = "/service-role/"
  #   permissions_boundary  = null
  #   tags                  = {}
  #   tags_all              = {}
}