provider "aws" {
  region = "ap-south-1"  # Choose your preferred region
}
 
# Generate a random string for naming
resource "random_pet" "name" {}
  
# Create an EC2 instance
resource "aws_instance" "web" {
  ami           = "ami-078264b8ba71bc45e"  # Check if this AMI is valid in ap-south-1
  instance_type = "t2.micro"               # Free tier instance type
  subnet_id     = "0564d815852d0eb07"
  vpc_security_group_ids = ["sg-0e598455eeca7dd6c"]
  key_name      = "test-kyp"               # Use just the name of the key pair, without .pem
}
 
output "instance_ip" {
  value = aws_instance.web.public_ip
}
