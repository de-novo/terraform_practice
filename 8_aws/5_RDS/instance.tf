
resource "aws_instance" "example" {
  ami           = var.AWS_AMI_LIST["ubuntu_22_04_x86"]
  instance_type = var.AWS_INSTANCE_TYPE

  # the VPC subnet 
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the key pair
  key_name = aws_key_pair.mykeypair.key_name


}


