
resource "aws_instance" "test" {
  ami           = var.AWS_AMI_LIST["ubuntu_22_04_x86"]
  instance_type = var.AWS_INSTANCE_TYPE

  # the VPC subnet 
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the key pair
  key_name = aws_key_pair.mykeypair.key_name

  #userdata
  # user_data = "#!/bin/bash\nsudo apt update\nsudo apt install -y nginx\nsudo systemctl start nginx\nsudo systemctl enable nginx"
  #uesrdata template
  user_data = data.template_cloudinit_config.cloudinit-example.rendered
}


resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "${var.AWS_REGION}a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "ebs-volume-1"
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = var.INSTANCE_DEVICE_NAME
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.test.id
}
