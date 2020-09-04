
### create index html
resource "null_resource" "generate-html" {
  depends_on = [
    aws_lambda_function.interceptor,
    module.apigateway_with_cors
  ]

  # create the index file from template
  provisioner "local-exec" {
    command = "sed 's,##lambda-url##,${module.apigateway_with_cors.lambda_url},g' ./template/index.tpl > ./html/index.html"
    working_dir = ".."
  }
}

### create new s3 bucket for static website
resource "aws_s3_bucket" "html-bucket" {
  bucket = "sat-html-bucket"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }
}

### upload index.html
resource "aws_s3_bucket_object" "upload-index" {
  bucket       = aws_s3_bucket.html-bucket.id
  key          = "index.html"
  source       = "../html/index.html"
  acl          = "public-read"
  content_type = "text/html"

  depends_on = [null_resource.generate-html]
}

### upload error.html
resource "aws_s3_bucket_object" "upload-error" {
  bucket       = aws_s3_bucket.html-bucket.id
  key          = "error.html"
  source       = "../html/error.html"
  acl          = "public-read"
  content_type = "text/html"
}

