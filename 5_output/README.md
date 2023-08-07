### Output

```
resource "aws_instance" "test" {
  ami           = var.AWS_AMI_LIST["ubuntu_22_04_x86"]
  instance_type = var.AWS_INSTANCE_TYPE

  provisioner "local-exec" {
    command = "echo ${aws_instance.test.private_ip} > private_ips.txt"
}


output "ip" {
  value = aws_instance.test.public_ip
}
```

위와 같이 output을 이용하여 각 리소스의 정보를 출력할수 있다.

또한, 각 리소스의 정보를 provisioner를 이용하여 파일도 생성할수 있다.
