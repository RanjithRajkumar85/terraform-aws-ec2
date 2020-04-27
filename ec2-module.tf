

# Create a new instance of the latest Ubuntu 14.04 on an
# t2.micro node with an AWS Tag naming it "HelloWorld"
provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}



resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.type 
  tags = {
    Name = "HelloWorld01"
  }
}


variable "type" {
	default = "t2.micro"
}


output "instance_ip_addr" {
  value = aws_instance.web.public_ip
}

