# Software provisioning

> 1~3에서는 인스턴스만 실행함. 즉, 평범한 이미지 리눅스 이미지였음

> 소프트웨어를 설치하고, provision 해야함.

### 방법

1. Packer를 통해 이미지를 만들어 수행할수 있음.

   - Packer는 이후 챕터에서 다룰 예정

2. AMI를 부팅후, 필요한 소프트웨어를 설치

   - file uploads를 사용해서 가능
   - 원격으로 파일을 실행하고, 스크립트를 할수있음
     - 이는 셰프, 퍼펫, **_앤서블_** 과같은 자동화 툴을 사용해서 가능

   > Chef는 테라폼 내에 통합되어 있음.

   - 테라폼 파일에 셰프 명령문을 포함가능.

        <br>

   > puppet agent은 remote-exec를 사용해서 사용가능

   - 현재 버전에서는 사용가능 할 수도 있음 (doc 확인)

     <br>

   > Ansible은 먼저 테라폼을 실행하고, IP주소를 출력후 {ansible-playbook}을 호스트들에서 실행 가능

   - 작업 흐름 스크립트로 자동화 할 수 있음
   - 테라폼 실행 -> 앤서블 실행 

    - 앤서블과 테라폼을 통합하는 3rd party initiatives 가 있음



### Software provisioning 구성하기

1. 키 발급
```shell
ssh-keygen -f mykey
```


2. VPC inbound 수정
  - 이것도 terraform으로 가능함.




