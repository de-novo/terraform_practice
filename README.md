# terraform_practice
테라폼 공부 repo

각 폴더 실습 후 반드시 destroy를 해주자!

안하면 요금폭탄 맞는다!


### 명령어

```sh
terraform paln

terraform apply 

terraform destroy

terraform fmt # 포맷터

terraform get # Download and update modules

terraform graph #

terraform import [options] ADDRESS ID

terraform output [options] [NAME] 
#리소스 출력 , 이름사용시 특정 리소스만 출력

terraform refresh # 원격상태 새로고침. 상태 파일과 원격 상태 간의 차이를 식별 

terraform remote # configure remote state storage

terraform show 

terraform state # 고급 상태 관리에 이 명령어를 사용할 수 있음
# 예를 들어, 리소스의 이름 변경하려면 
terraform state mv aws_instance.example aws_instance.production

terraform taint # 오염된 자원을 수동으로 표시,다음 실행시 파괴후 다시실행

terraform validate # 테라폼 문법 검증

terraform untaint # undo a taint
```