# resource "aws_security_group" "allow-ssh" {
#   vpc_id      = aws_vpc.main.id
#   name        = "allow-ssh"
#   description = "allow ssh from anywhere"

#   #in
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   #out
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "allow-ssh"
#   }
# }


resource "aws_security_group" "example-instance" {
  vpc_id      = aws_vpc.main.id
  name        = "allow-ssh"
  description = "allow ssh from anywhere"

  #in
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #out
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "example-instance"
  }
}

resource "aws_security_group" "allow-mariadb" {
  vpc_id      = aws_vpc.main.id
  name        = "allow-mariadb"
  description = "allow mariadb"

  #in
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.example-instance.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-mariadb"
  }
}
