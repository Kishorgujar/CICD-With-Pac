provider "aws" {
  region = "ap-south-1"  # Choose your preferred region
}
 
# Generate a random string for naming
resource "random_pet" "name" {}
 
# Create a new Security Group allowing HTTP (port 80) and SSH (port 22) access
resource "aws_security_group" "web_sg" {
  name        = "allow_http_ssh"
  description = "Allow inbound HTTP and SSH traffic"
  vpc_id     = "vpc-01402a4bf417f447f"  # Ensure this is the correct VPC ID
 
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Consider limiting this to specific IPs
  }
 
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
 
# Create an EC2 instance
resource "aws_instance" "web" {
  ami           = "ami-078264b8ba71bc45e"  # Check if this AMI is valid in ap-south-1
  instance_type = "t2.micro"               # Free tier instance type
  key_name      = "test-kyp"               # Use just the name of the key pair, without .pem
  security_groups = [aws_security_group.web_sg.name]  # Attach security group
}
 
output "instance_ip" {
  value = aws_instance.web.public_ip
}
