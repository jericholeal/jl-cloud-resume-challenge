# IAM Role for Lambda execution
resource "aws_iam_role" "jericho_crc_site_visitor_lambda_exec" {    
  name = "crc_visitor_counter-role-w5vyatiy"

  # AWS assume policy
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
      Statement = [{
          Effect = "Allow",
          Principal = {
            Service = "lambda.amazonaws.com"
          },
          Action = "sts:AssumeRole"
      }]
  })
}

# IAM Policy for Lambda execution role
resource "aws_iam_role_policy" "jericho_crc_site_visitor_lambda_policy" {
  name = "crc_visitor_counter_exec_policy"
  role = aws_iam_role.jericho_crc_site_visitor_lambda_exec.id

  # Policy for Lambda execution role
  policy = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Effect = "Allow",
          Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
              "logs:PutLogEvents"
              ],
              Resource = local.lambda_execution_logs_arn
          },
          {
            Effect = "Allow",
            Action = [
              "dynamodb:PutItem",
              "dynamodb:GetItem",
              "dynamodb:UpdateItem"
              ],
            Resource = local.dynamodb_table_arn
          }
      ]
  })
}

# Lambda function resource
resource "aws_lambda_function" "jericho_crc_site_visitor_counter" {
  function_name    = var.lambda_function_name
  s3_bucket        = var.lambda_s3_bucket
  s3_key           = var.lambda_s3_key
  handler          = "${var.lambda_function_name}.lambda_handler"
  runtime          = "python3.9"
  role             = aws_iam_role.jericho_crc_site_visitor_lambda_exec.arn

  environment {
    variables = {
      TABLE_NAME = var.dynamodb_table_name
      PARTITION_KEY = var.dynamodb_table_partition_key
      PARTITION_VALUE = var.dynamodb_table_partition_value
      COUNTER_ATTRIBUTE = var.dynamodb_counter_attribute
      }
  }

  tags = {
    Project = "jericho-crc-site"
  }
}
