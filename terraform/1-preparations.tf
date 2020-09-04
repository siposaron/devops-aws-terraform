terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.region
}

### build jar (lambda)
resource "null_resource" "local-build" {
  provisioner "local-exec" {
    command = "./mvnw clean package -DskipTests"
    working_dir = "../aws-interceptor"
  }

  provisioner "local-exec" {
    command = "mv *-aws.jar ${var.jar-name}"
    working_dir = "../aws-interceptor/target"
  }
}