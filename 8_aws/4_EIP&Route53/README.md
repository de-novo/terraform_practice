# EIP

- 탄력적 IP

- 고정된 공용 IP

-> EC2는 생성 및 재시작 마다 public_ip가 변경됨.

- 이는 매번 인스턴스를 재시작할때마다 public_ip를 확인해야한다는 소리임.
- 매우 귀찮고 번거로움, 또한 Domain을 적용한다 생각하면 비효율적.

***주의: EIP를 예약하고, 할당하지 않으면 비용지불; 사용하지 않는 IP는 제거해주자***

```terraform

resource "aws_instance" "example" {
...

    private_ip = "10.0.1.4" # 이렇게 할시 private_ip도 고정할 수 있음
}

resource "aws_eip" "example-eip" {
    instance = aws_instance.example.id
    vpc = true
}

```


