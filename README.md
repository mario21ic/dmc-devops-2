# dmc-codedeploy

Requisitos:
- Terraform 1.2.2
- Aws cli

Configurar:
```
$ aws configure
aws credentials:
aws access:
region: us-east-2
```

### Infrastructure as Code:
```
cd iac
terraform init
terraform init -upgrade # for plugins and modules

cp ~/Downloads/Alo2.pem ./
# De ser necesario cambiar los valores terraform.tfvars
terraform apply
```

### Deploy from localhost:
```
./scripts/aws_artifact_build 4
./scripts/aws_artifact_upload dmc-devops-code mario 4.zip
./scripts/aws_codedeploy_deployment draft-demo3-cd draft-demo3-dg dmc-devops-code mario 4.zip
```

### Deploy from Jenkins:
Create a jenkins job using Jenkinsfile
