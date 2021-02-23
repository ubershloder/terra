provider "aws" {

  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  user_data = <<-EOF
              echo "hello" > index.html
              nohup busybox httpd -f -p 80 &
              EOF
lifecycle{
create_before_destroy = true
}
  tags = {
    Name = "terraform"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-instance"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
value = aws_instance.public_ip
description = "public ip"
}
