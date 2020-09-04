
### create s3 bucket
resource "aws_s3_bucket" "sat-bucket" {
  depends_on = [ 
    null_resource.local-build 
  ]
  
  bucket = "sat-bucket-lambda"

  versioning {
    enabled = true
  }
}

### upload jar
resource "aws_s3_bucket_object" "file-upload" {
  depends_on = [
    aws_s3_bucket.sat-bucket,
  ]

  bucket = aws_s3_bucket.sat-bucket.id
  key    = "v1/${var.jar-name}"
  source = "../aws-interceptor/target/${var.jar-name}"
}
