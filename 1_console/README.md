```terraform
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


```

```shell
terraform console
> var.hi_terraform
"hi_terraform"

> "start ${var.hi_terraform}"
"start hi terraform"

> var.mymap
tomap({
  "key1" = "value1"
  "key2" = "value2"
  "key3" = "value3"
})

> var.mymap["key1"]
"value1"

> var.myStringlist
tolist([
  "value1",
  "value2",
  "value3",
])

> var.mylist
tolist([
  1,
  2,
  3,
])

> element(var.mylist, 1)
2

> slice(var.mylist,0,1)
tolist([
  1,
])
```
