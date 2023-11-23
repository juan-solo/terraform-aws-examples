resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    to_port   = 8080
    protocol  = "tcp"
    from_port = 8080
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

resource "aws_instance" "example" {
  user_data     = <<EOT
#!/bin/bash
echo "Hello, World" > index.html
nohup busybox httpd -f -p 8080 &

EOT
  instance_type = "t2.small"
  ami           = "ami-785db401"

  tags = {
    Name = "terraform-example"
  }

  vpc_security_group_ids = [
    aws_security_group.instance.id,
  ]
}

