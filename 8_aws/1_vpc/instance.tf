resource "aws_instance" "test" {
  ami           = var.AWS_AMI_LIST["ubuntu_22_04_x86"]
  instance_type = var.AWS_INSTANCE_TYPE

  # the VPC subnet 
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the key pair
  key_name = aws_key_pair.mykeypair.key_name

  provisioner "local-exec" {
    command = "echo ${aws_instance.test.private_ip} > private_ips.txt"
  }

  connection {
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
     host        = self.public_ip    
  }
}

output "ip" {
  value = aws_instance.test.public_ip
}
