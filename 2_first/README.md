#Set AWS

1. sign up aws

2. set iam \_adnub

3. aws cli conf igure

```
terraform init
terraform plan -parallelism=30
terraform apply -parallelism=30
terraform destory
```

```
terraform plan
===
terraform plan -out file ; terraform apply file ; rm file
```

**_production에 적용할때는 가급적 아래 코드사용_**

```
terraform plan -out changes.terraform
terraform plan changes.terrafrom
rm changes.terraform
```

**_production에서는 아래코드는 절대 사용X_**

모든 리소스를 제거함.

```
terraform destroy
```
