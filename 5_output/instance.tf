resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "test" {
  ami           = var.AWS_AMI_LIST["ubuntu_22_04_x86"]
  instance_type = var.AWS_INSTANCE_TYPE

  key_name = aws_key_pair.mykey.key_name

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.test.private_ip} > private_ips.txt"
  }

  connection {
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}


output "ip" {
  value = aws_instance.test.public_ip
}
