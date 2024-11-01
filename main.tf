# Specify the provider (AWS) and use the named profile 'demo_account'
provider "aws" {
  region  = "us-east-1"     # Replace with your preferred region
}

# Security group allowing inbound traffic on SSH port 22 and custom TCP port 8000
resource "aws_security_group" "custom_tcp_sg" {
  name        = "custom_tcp_and_ssh_sg"
  description = "Allow inbound SSH and custom TCP traffic on port 8000"

  # Allow inbound SSH traffic (port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows SSH from any IP (adjust as needed)
  }

  # Allow inbound custom TCP traffic (port 8000)
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows traffic on port 8000 from any IP
  }

  # Allow all outbound traffic (default rule)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allows all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create the EC2 instance with Ubuntu OS
resource "aws_instance" "my_ec2" {
  ami           = "ami-04505e74c0741db8d"  # Ubuntu 22.04 LTS AMI ID for us-east-1
  instance_type = "t2.micro"  # Free-tier eligible instance type

  key_name = "project_demo"  # Use the existing key pair 'project_demo.pem'

  # Attach the security group
  vpc_security_group_ids = [aws_security_group.custom_tcp_sg.id]

  # Tag your instance (optional)
  tags = {
    Name = "My-Terraform-Ubuntu-EC2"
  }
}

# Output the public IP of the instance
output "instance_public_ip" {
  value = aws_instance.my_ec2.public_ip
}
