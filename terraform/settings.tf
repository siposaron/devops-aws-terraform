variable "region" {
  default = "eu-west-2"
}

variable "jar-name" {
  default = "aws-interceptor.jar"
}

variable "lambda-runtime" {
  default = "java11"
}

variable "api-path" {
  default = "interceptor"
}

variable "api-env-stage-name" {
  default = "dev"
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}

data "aws_region" "current" {}

output "region" {
  value = "${data.aws_region.current.name}"
}

variable "key-pair-name" {
  description = "Desired name of AWS key pair"
}

variable "public-key-path" {
  description = <<DESCRIPTION
    Path to the SSH public key to be used for authentication.
    Example: ~/.ssh/terraform.pub
DESCRIPTION
}

variable "private-key-path" {
  description = <<DESCRIPTION
    Path to the SSH private key to be used for authentication.
    Used by the provisioner, to connect to the EC2 instance.
    Example: ~/.ssh/terraform
DESCRIPTION
}