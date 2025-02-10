
// Provider ------------------------------------

provider "aws" {
  region = var.region
}

// EC2 Instance ------------------------------------
resource "aws_instance" "this" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  subnet_id                   = var.private_subnet_id
  key_name                    = "key-aws-1"
  associate_public_ip_address = false
  vpc_security_group_ids      = [var.security_group_id]

  root_block_device {
    volume_size = 20 # GB
    volume_type = "gp2"
  }

  user_data = <<-EOF
    #!/bin/bash
    exec > /tmp/startup.log 2>&1
    set -x
    sudo yum update -y
    sudo yum install -y httpd
    echo "Hi! I'm an AWS Instance in Region '${var.region}' in AZ '${var.availability_zone}'." | sudo tee /var/www/html/index.html
    sudo systemctl start httpd
    sudo systemctl enable httpd
  EOF

  tags = {
    Name = "privateinstance-nr1"
  }
}

// Data source ------------------------------------

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
