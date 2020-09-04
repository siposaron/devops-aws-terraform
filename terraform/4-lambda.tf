resource "aws_lambda_function" "interceptor" {
  depends_on = [
    aws_s3_bucket_object.file-upload,
    aws_iam_role.lambda-exec
  ]
  runtime          = var.lambda-runtime
  function_name    = "sat-interceptor"
  s3_bucket = aws_s3_bucket.sat-bucket.id
  s3_key    = "v1/${var.jar-name}"
  handler     = "ro.codespring.interceptor.handler.InterceptorRequestHandler"
  timeout     = 20
  memory_size = 512

  role = aws_iam_role.lambda-exec.arn

  environment {
    variables = {
      FUNCTION_NAME = "greeter"
    }
  }
}

module "apigateway_with_cors" {  
  source  = "alparius/apigateway-with-cors/aws"
  version = "0.3.1"
  lambda_function_name = aws_lambda_function.interceptor.function_name  
  lambda_invoke_arn    = aws_lambda_function.interceptor.invoke_arn  
  path_part            = "${var.api-path}"
  http_method = "POST"
}
