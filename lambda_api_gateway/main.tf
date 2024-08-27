resource "aws_lambda_function" "getapi" {
   function_name = "getMessageAPI"

   # The bucket name as created earlier with "aws s3api create-bucket"
   s3_bucket = "my-tf-bukcet"
   s3_key    = "getMessages.zip"
   handler = "getMessages.lambda_handler"
   runtime = "python3.6"

   role = aws_iam_role.lambda_exec.arn
}

resource "aws_lambda_function" "postpushapi" {
   function_name = "postpushAPI"

   # The bucket name as created earlier with "aws s3api create-bucket"
   s3_bucket = "my-tf-bukcet"
   s3_key    = "postMessages.zip"
   handler = "postMessages.lambda_handler"
   runtime = "python3.6"

   role = aws_iam_role.lambda_exec.arn
}


resource "aws_iam_role_policy_attachment" "iam" {
  role       = "${aws_iam_role.lambda_exec.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}


resource "aws_iam_policy" "policy" {
  name        = var.aws_dynamo_db_iam_policy
  path        = "/"
  description = var.aws_dynamo_db_iam_policy
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "dynamodb:*",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "lambda_exec" {
   name = "serverless_lambda"
   assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


#----------------------------------------------------------------------------------------------
#   API Gateway 
#----------------------------------------------------------------------------------------------
resource "aws_api_gateway_rest_api" "api_gateway_name" {
  name = var.apiname

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}


# Create Resources
resource "aws_api_gateway_resource" "proxy" {
   rest_api_id = aws_api_gateway_rest_api.api_gateway_name.id
   parent_id   = aws_api_gateway_rest_api.api_gateway_name.root_resource_id
   path_part   = var.aws_api_gateway_resource_path_part
}


# GET Method
resource "aws_api_gateway_method" "proxy" {
   rest_api_id   = aws_api_gateway_rest_api.api_gateway_name.id
   resource_id   = aws_api_gateway_resource.proxy.id
   http_method   = "GET"
   authorization = "NONE"
}


resource "aws_api_gateway_integration" "lambda" {
   rest_api_id   = aws_api_gateway_rest_api.api_gateway_name.id
   resource_id   = aws_api_gateway_resource.proxy.id
   http_method = aws_api_gateway_method.proxy.http_method

   integration_http_method = "GET"
   type                    = "AWS"
   uri                     = aws_lambda_function.getapi.invoke_arn
}


resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_name.id
   resource_id   = aws_api_gateway_resource.proxy.id
   http_method = aws_api_gateway_method.proxy.http_method
  status_code = "200"
}


resource "aws_api_gateway_integration_response" "MyDemoIntegrationResponse" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_name.id
   resource_id   = aws_api_gateway_resource.proxy.id
   http_method = aws_api_gateway_method.proxy.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code
  depends_on = [ aws_api_gateway_integration.lambda ]
}



# POST Method
resource "aws_api_gateway_method" "proxy2" {
   rest_api_id   = aws_api_gateway_rest_api.api_gateway_name.id
   resource_id   = aws_api_gateway_resource.proxy.id
   http_method   = "POST"
   authorization = "NONE"
}


resource "aws_api_gateway_integration" "lambda2" {
   rest_api_id   = aws_api_gateway_rest_api.api_gateway_name.id
   resource_id   = aws_api_gateway_resource.proxy.id
   http_method = aws_api_gateway_method.proxy2.http_method

   integration_http_method = "POST"
   type                    = "AWS"
   uri                     = aws_lambda_function.getapi.invoke_arn
}


resource "aws_api_gateway_deployment" "apideployment" {
   depends_on = [
     aws_api_gateway_integration.lambda,
     aws_api_gateway_integration.lambda2,
   ]
   rest_api_id = aws_api_gateway_rest_api.api_gateway_name.id
   stage_name  = "dev"
}


# Lambda Permission Invoke API Gateway
resource "aws_lambda_permission" "apigw_lambda_get" {
  statement_id  = "AllowExecutionFromAPIGatewayget"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.getapi.function_name 
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:875012586337:${aws_api_gateway_rest_api.api_gateway_name.id}/*/${aws_api_gateway_method.proxy.http_method}${aws_api_gateway_resource.proxy.path}"
}



# Lambda Permission Invoke API Gateway
resource "aws_lambda_permission" "apigw_lambda_post" {
  statement_id  = "AllowExecutionFromAPIGatewaypost"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.getapi.function_name 
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:875012586337:${aws_api_gateway_rest_api.api_gateway_name.id}/*/${aws_api_gateway_method.proxy2.http_method}${aws_api_gateway_resource.proxy.path}"
}