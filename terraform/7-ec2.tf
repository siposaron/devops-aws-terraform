### key pair to connect to instance
resource "aws_key_pair" "auth" {
  key_name   = var.key-pair-name
  public_key = file(var.public-key-path)
}

### the instance itself
resource "aws_instance" "ec2" {
  depends_on = [
    module.apigateway_with_cors,
    aws_vpc.default,
    null_resource.generate-html
  ]
  instance_type = "t2.micro"

  # lookup the correct AMI based on the region we specified
  ami = "ami-00108fa4bd389cbd2"

  # our security group to allow HTTP and SSH access
  vpc_security_group_ids = [aws_security_group.default.id]

  # we're going to launch into the same subnet as our ELB. In a production environment
  # it's more common to have a separate private subnet for backend instances.
  subnet_id = aws_subnet.default.id

  tags = {
    owner = "sat"
  }

  # print pulic IP to file
  provisioner "local-exec" {
    command = "echo ${aws_instance.ec2.public_ip} > public_ip.txt"
  }

  # the name of our SSH keypair we created above
  key_name = aws_key_pair.auth.key_name

  # the connection block tells our provisioner how to communicate with the resource (instance)
  connection {
    type = "ssh"
    # The default username for our AMI
    user = "ubuntu"
    host = self.public_ip
    # The connection will use the local SSH agent for authentication.
    private_key = file(var.private-key-path)
  }

  provisioner "file" {
    source      = "../html/index.html"
    destination = "/home/ubuntu/index.html"
  }

  provisioner "file" {
    source      = "../html/error.html"
    destination = "/home/ubuntu/error.html"
  }

  # we run a remote provisioner on the instance after creating it, on port 80, by default
  provisioner "remote-exec" {
    inline = [
      "sudo apt install nginx -y",
      "sudo systemctl start nginx",
      "sudo cp /home/ubuntu/index.html /var/www/html/index.html",
      "sudo cp /home/ubuntu/error.html /var/www/html/error.html"
    ]
  }

}