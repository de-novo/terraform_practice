resource "aws_instance" "example" {
  ami           = var.INSTANCE_DEVICE_NAME["ubuntu_20_04_x86"]
  instance_type = "t2.micro"
  #role
  iam_instance_profile = aws_iam_instance_profile.s3-mybucket-role-instaceprofile.name

}


## bucket
resource "aws_s3_bucket" "mybucket" {
  bucket = "mybucket"
  acl    = "private"
  tags = {
    Nmae = "mybucket-c29df1"
  }
}
