# dmc-codedeploy

### Infrastructure as Code:
```
cd iac
terraform init
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
