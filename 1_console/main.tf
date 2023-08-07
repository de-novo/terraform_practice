variable "hi_terraform" {
  type    = string
  default = "hi terraform"
}


variable "mymap" {
  type = map(string)
  default = {
    key1 = "value1"
    key2 = "value2"
    key3 = "value3"
  }
}

variable "myStringlist" {
  type    = list(string)
  default = ["value1", "value2", "value3"]
}

variable "mylist" {
  type    = list(any)
  default = [1, 2, 3]
}
