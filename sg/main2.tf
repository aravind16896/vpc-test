# main.tf

provider "aws" {
  region = "us-east-1"  # Update with your desired AWS region
  # Optionally, you can specify AWS access and secret keys here or use other authentication methods.
  # See Terraform documentation for more details: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
}

resource "aws_security_group" "robo" {
  name        = "robo"
  description = "Security group for the robo application"

  // Inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "robo"
  }
}
