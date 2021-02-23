resource "aws_launch_conf" "example" {
image_id = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
security_groups = [aws_security_group.instance.id]

user_data = <<- EOF
     #!/bin/bash
     echo "terraform" > index.html
     nohup busybox httpd -f -p ${var.server_port} &
     EOF
resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name

min_size = 2
max_size = 4
tag {
key = "Name"
value = "terraform asg"
propagate_at_launch = true
}
}
