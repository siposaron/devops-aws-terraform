### create a vpc to launch our instances into
resource "aws_vpc" "default" {
  cidr_block = "10.32.0.0/16"

  tags = {
    owner = "sat"
  }

  depends_on = [
    null_resource.generate-html
  ]
}

### create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    owner = "sat"
  }
}

### grant the vpc internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.default.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

### create a subnet to launch our instances into
resource "aws_subnet" "default" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.32.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    owner = "sat"
  }
}

### default security group to access the instances over SSH and HTTP
resource "aws_security_group" "default" {
  name        = "sat-secgroup"
  description = "Used in the terraform"
  vpc_id      = aws_vpc.default.id

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    owner = "sat"
  }
}