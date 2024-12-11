resource "aws_instance" "instance" {
  count = length(var.private_subnets)

  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  key_name      = "key-aws-1"
  subnet_id     = element(var.private_subnets, count.index)
  security_groups = [aws_security_group.sg.id]

  user_data = base64encode(<<-EOT
    #!/bin/bash
    sudo yum install httpd -y
    echo "Instance-${var.region}-Nr${count.index + 1}" | sudo tee /var/www/html/index.html
    sudo systemctl start httpd
    sudo systemctl enable httpd
  EOT)
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
