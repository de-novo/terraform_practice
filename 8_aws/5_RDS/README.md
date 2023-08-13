# RDS

- 아마존에서 제공하는 관리형 데이터베이스 솔루션

### 지원 DB

- mysql
- postgreSQL
- mariaDB
- Oracle ...

## 생성단계

1. 서브넷 그룹 생성

   - 서브넷이 데이터베이스에 속할지 지정.

2. Parameter group 생성

   - 데이터베이스를 설정을 변경하기 위해 매개변수를 지정할 수 있음.

3. 보안 그룹 생성.

   - RDS인스턴스로 들어오는 트래픽을 허용
   - ex: MySQL : 3306

   - 인스턴스1 <-> RDS만 데이터 베이스에 액세스할 수 깅ㅅ게 설정 가능

```tf
# parameter group

resource "aws_db_parameter_group" "mariadb-parameters" {
    name = "mariadb-parameters"
    family = "mariadb 10.1"
    description = "MariaDB parameter group"

    parameter {
        name = 'max_allowed_packet"
        value = 16777216
    }
}

```

```tf
# 서브넷 그룹
resource "aws_db_subnet_group" "mariadb-subnet" {
    name = "mariadb-subnet"
    description = "RDS subnet group"

    subnet_ids = [aws_subnet.main-private-1.id, aws_subnet.main-private-2.id]
}

# 사무실이나 집에서 액세스 할 수 있게 하려면, 공용 서브넷을 선택해야함.

# High Availability를 활성화할 경우, 두 서브넷 모두에 인스턴스 생성됨
```

```tf
# 보안 그룹
resource "aws_security_group" "allow-mariadb" {
    vpc_id = aws_vpc.main.id
    name = "allow-mariadb"
    description = "allow-mariadb"

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [aws_security_group.example.id]

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_block = ["0.0.0.0/0"]
        self = true
    }
    tags = {
        Name = "allow-mariadb"
    }
}
```

```tf
# RDS

resource "aws_db_instance" "mariadb" {
    allocated_storage = 100 # 100GB
    engine = "mariadb"
    engine_version = "10.1.14"
    instance_class = "db.t2.small" # free tier = micro
    identifier = "mariadb"
    name = "mariadb"
    username = "root" #user name
    password = password
    db_subnet_group_name = aws_db_subnet_group.mariadb-subnet.name
    parameter_group_name = "mariadb-parameters"

    multi_az = false # true = high availability => 2개 인스턴스 생성됨

    vpc_securiry_group_ids = aws_security_group.allow-mariadb.id
    storage_type = "gp2"
    backup_retention_period = 30
    availability_zone = aws_subnet.main-private-1.availability_zone

    tags = {
        Name = "mariadb-instance"
    }
}

```



## 적용

```sh
terraform apply -var RDS_PAWSSWORD = MY_PASSWORD_

```