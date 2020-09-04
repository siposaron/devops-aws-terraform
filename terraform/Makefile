.PHONY: up down up-debug ec2

up:
	terraform apply --auto-approve

up-debug:
	TF_LOG=DEBUG OCI_GO_SDK_DEBUG=v terraform apply --auto-approve

down:
	terraform destroy --auto-approve

ec2:
	terraform taint aws_instance.ec2
	terraform apply --auto-approve
