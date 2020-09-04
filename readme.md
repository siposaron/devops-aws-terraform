# Terraform with AWS

This is a sample project for creating a Java11 & Spring based AWS Lambda. 

Terraform scripts do:

- create JAR file
- create S3 bucket
- copy JAR to S3 bucket
- create Lambda from S3 JAR, API Gateway with CORS enabled
- create index.html from template file, setting the Lambda URL to be called
- create EC2 instance from an Ubuntu 20.04 LTS AMI
- install Nginx and copy html files under www directory
- check the public_ip.txt for the EC2 access

## Prerequisites

1. `AWS` account
2. `Terraform` installed. Please check: https://learn.hashicorp.com/tutorials/terraform/infrastructure-as-code
3. Generated public/private key for EC2 instance placed under your `~/.ssh/terraform` directory (Hint: `ssh-keygen -t rsa -f terraform` skipping passphrase for demo purposes). If it is in a different directory, just update the file locations in `./terraform/terraform.tfvars` file under project.
4. `Make` installed

## Running the scripts

Switch to `./terraform` directory under this project. 

- Create infrastructure: `make up`
- Destroy infrastructure: `make down`
- Recreate EC2 instance: `make ec2`
