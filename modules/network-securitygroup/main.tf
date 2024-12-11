
#-----------------------------

variable "vpc_id" {
  description = "The ID of the VPC to associate with the security group"
  type        = string
}

#-----------------------------

resource "aws_security_group" "http_https" {
    
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "http-https-sg"
  }
}

#-----------------------------

output "http_https_sg_id" {
  value = aws_security_group.http_https.id
}
