# Create REST API for lambda function integration
resource "aws_api_gateway_rest_api" "lambda_function_trigger_api" {
  name = "lambda_function_trigger_api"
  description = "API gateway for visitor counter Lambda function trigger"
}

# Create resource path
resource "aws_api_gateway_resource" "increment_path" {
  rest_api_id = aws_api_gateway_rest_api.lambda_function_trigger_api.id
  parent_id = aws_api_gateway_rest_api.lambda_function_trigger_api.root_resource_id
  path_part = "increment"
}

# Create POST method on path
resource "aws_api_gateway_method" "post_method" {
  rest_api_id = aws_api_gateway_rest_api.lambda_function_trigger_api.id
  resource_id = aws_api_gateway_resource.increment_path.id
  http_method = "POST"
  authorization = "NONE"
}

# Integrate POST method with Lambda function
resource "aws_api_gateway_integration" "lambda_function_integration" {
  rest_api_id = aws_api_gateway_rest_api.lambda_function_trigger_api.id
  resource_id = aws_api_gateway_resource.increment_path.id
  http_method = aws_api_gateway_method.post_method.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = aws_lambda_function.crc_visitor_counter.invoke_arn
}

# Create OPTIONS method for CORS support
resource "aws_api_gateway_method" "options_method" {
  rest_api_id = aws_api_gateway_rest_api.lambda_function_trigger_api.id
  resource_id = aws_api_gateway_resource.increment_path.id
  http_method = "OPTIONS"
  authorization = "NONE"
}

# Integrate OPTIONS method with Lambda function
resource "aws_api_gateway_integration" "options_integration" {
  rest_api_id = aws_api_gateway_rest_api.lambda_function_trigger_api.id
  resource_id = aws_api_gateway_resource.increment_path.id
  http_method = aws_api_gateway_method.options_method.http_method
  integration_http_method = "POST"
  type = "MOCK"

  request_templates = {
    "application/json" = jsonencode({
      statusCode = 200
    })
  }

  passthrough_behavior = "WHEN_NO_MATCH"
}

# Grant permission for API Gateway to invoke Lambda function
resource "aws_lambda_permission" "lambda_api_gateway_permission" {
    statement_id = "AllowAPIGatewayInvoke"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.crc_visitor_counter.function_name
    principal = "apigateway.amazonaws.com"
    source_arn = "${aws_api_gateway_rest_api.lambda_function_trigger_api.execution_arn}/*/POST/increment"
}

# Deploy API (required for API Gateway to be accessible)
resource "aws_api_gateway_deployment" "lambda_function_trigger_deployment" {
    depends_on = [aws_api_gateway_integration.lambda_function_integration]
    rest_api_id = aws_api_gateway_rest_api.lambda_function_trigger_api.id
    description = "Deployment for visitor counter Lambda function API"
}

resource "aws_api_gateway_stage" "lambda_function_trigger_stage" {
  rest_api_id = aws_api_gateway_rest_api.lambda_function_trigger_api.id
  deployment_id = aws_api_gateway_deployment.lambda_function_trigger_deployment.id
  stage_name = "prod"
  description = "Production stage for visitor counter Lambda function API"
}

