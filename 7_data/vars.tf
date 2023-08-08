variable "AWS_REGION" {
  default = "ap-northeast-2"
}

variable "AWS_AMI_LIST" {
  type = map(string)
  default = {
    "ubuntu_20_04_x86" = "ami-04341a215040f91bb"
    "ubuntu_20_04_arm" = "ami-0ac62099928d25fec"
    "ubuntu_22_04_x86" = "ami-0c9c942bd7bf113a2"
    "ubuntu_22_04_arm" = "ami-00fdfe418c69b624a"
  }
}
