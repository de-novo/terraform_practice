# IAM

- AWS 리소스에 접근을 관리할 수 있는 서비스

- AWS에서 스룹, 사용자, 그리고 IAM에 대한 Role을 만들 수 있음

사용자는 인증을 할수 있고 로그인과 암호를 이용하고, 선택적으로 토큰을 이용할 수도 있음

구글 인증 프로그램 호환 소프트웨어를 이용해서 MFA라는 다단계 인증을 할 수 있음

아니면, 액세스키와 시크릿키를 사용할수도 있음

Role은 사용자와 서비스에 대해 보통 가질 수 없는 임시 액세스 권한을 줌

### Roles

- EC2 인스턴스에 연결 가능

  - ㅇ인스턴스에서 사용자나 서비스는 접근 자격 증명을 얻을 수 있고, 접근 자격 증명을 사용해서 사용자나 서비스가 무언가를 할 수 있는 권한을 주는 role을 대신 할 수 있다.

  ### 예시

        (mybucket-access)라는 역할을 생성
        instance1에 role할당

        instance1은 mybucket이라는 버킷에 있는 아이템을 읽고 쓸 수있는 사용 권한얻음

```tf

resource "aws_iam_group" "administrators" {
    name = "administrators"
}

resource "aws_iam_policy_attachment" "administratores-attach" {
    name = "administrators-attach"
    groups = [aws_iam_group.administators.name]
    #policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"

    policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": "*",
                "Resource": "*"
            }
        ]
    }
    EOF
    >>
}

```

```tf
# uesr

resource "aws_iam_user" "admin1" {
    name = "admin1"
}

resource "aws_iam_user" "admin2" {
    name = "admin2
}

resource "aws_iam_group_membership" "administrators-users" {
    name = "administrators-users"
    users = [
     aws_iam_user.admin1.name,
     aws_iam_user.admin2.name
    ]
    group = aws_iam_gorup_administrators.name
}

```
