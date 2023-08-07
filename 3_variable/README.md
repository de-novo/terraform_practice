# Variable

- 파일을 분리해서 관리하는 것이 좋음

- 시크릿 같이 숨기기 위해 사용 (노출되면 안되는 값)
- 변경될 수 있는 요소에 사용

- 테라폼 코드를 재사용 가능하게함

이미 first에 변수를 사용하여 구성을 하였음.

```
//파일명

provider.tf
    - provider

variables.tf
    - 변수 선언

terraform.tfvars
    - 선언한 변수에 값 할당
    - 기본값을 재정의 하려는 경우에만 해당 변수에대한 설정해야함.

    - tfvars에도 정의되지 않은 상태에서 plan과 같은 명령어를 실행할경우
        입력을 받음
    
```

### gitignore

```
# Local .terraform directories
**/.terraform/*

# .tfstate files
*.tfstate
*.tfstate.*

# Crash log files
crash.log
crash.*.log

# Exclude all .tfvars files, which are likely to contain sensitive data, such as
# password, private keys, and other secrets. These should not be part of version
# control as they are data points which are potentially sensitive and subject
# to change depending on the environment.
*.tfvars
*.tfvars.json

# Ignore override files as they are usually used to override resources locally and so
# are not checked in
override.tf
override.tf.json
*_override.tf
*_override.tf.json

# Include override files you do wish to add to version control using negated pattern
# !example_override.tf

# Include tfplan files to ignore the plan output of command: terraform plan -out=tfplan
# example: *tfplan*

# Ignore CLI configuration files
.terraformrc
terraform.rc
```

**_ .tfvar 파일은 자동화 단계에서 진행 작성 git secret등을 이용하여 _**
