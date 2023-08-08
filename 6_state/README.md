# remote state

테라폼은 인프라의 원격 상태를 유지함

원격 상태는 terraform.tfstate라는 파일에 저장함

이전상태의 백업은 terraform.rfstate.backup이라는 파일에 백업됨.

```shell
terraform apply
```

를 실행할 때 새로운 state파일과 백업이 디스크에 저장됨.

## virsion control

버전 제어에서 terraform.tfstate를 유지할 수 있다.

1. git 사용
   - 충돌이 일어날수 있음. 주의....

## backend를 이용하여 state 원격 저장

기본 백엔드를 로컬 백엔드라고 함.

백엔드를 설정하지 않으면, 백엔드는 로컬임.

### backend 종류

1. local

2. s3 (with a locking mechanism using dynamoDB)

3. consul (with locking)

4. terraform enterprise (the commercial solution)

원격상태는 항상 전체 팀에서 사용할 수 있다는 확실한 이점이 있음

하지만, 동시에 작업을 수행하면 충돌 문제가 일어날수 있음

그렇기에 필요한것이 locking임.

같은 시간대에 오직 한 사람만이 상태를 업데이트 할 수 있도록 함.

### 주의

백엔드 코드는 다른 초기화를 수행하기 전에 이미 AWS와 S3에 Access해야함
그렇기에 변수를 사용할수 없음.

<br>

백엔드에 저장한 state파일을 읽기위해서는 data 를 사용하면됨

```
data "terraform_remote_state" "aws-state" {
    backend = "s3"
    config {
        bucket = "terraform-state"
        key = "terraform.tfstate"
        access_key = var.AWS_ACCESS_KEY
        secret_key = var.AWS_SECRET_KEY
        region = var.AWS_REGION
    }
}

```

이 data는 read-only임
