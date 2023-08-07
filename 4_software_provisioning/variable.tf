variable "AWS_AMI_LIST" {
  type = map(string)
  default = {
    "ubuntu_20_04_x86" = "ami-04341a215040f91bb"
    "ubuntu_20_04_arm" = "ami-0ac62099928d25fec"
    "ubuntu_22_04_x86" = "ami-0c9c942bd7bf113a2"
    "ubuntu_22_04_arm" = "ami-00fdfe418c69b624a"
  }
}

variable "AWS_REGION" {
  type    = string
  default = "ap-northeast-2"
}

variable "AWS_INSTANCE_TYPE" {
  type    = string
  default = "t2.micro"
}

variable "INSTANCE_USERNAME" {
  type    = string
  default = "ubuntu"
}

variable "PATH_TO_PUBLIC_KEY" {
  type    = string
  default = "~/.ssh/mykey"
}

variable "PATH_TO_PRIVATE_KEY" {
  type    = string
  default = "~/.ssh/mykey.pub"
}

