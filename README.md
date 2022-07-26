# dmc-codedeploy

### Infrastructure as Code:
```
cd iac
terraform init
terraform apply
```

### EC2: install Aws Codedeploy agent:
```
sudo yum install ruby -y
wget https://aws-codedeploy-us-east-2.s3.us-east-2.amazonaws.com/latest/install
chmod +x install
sudo ./install auto

sudo amazon-linux-extras install nginx1 -y
sudo service nginx start
sudo systemctl enable nginx
```

### Deploy from localhost:
```
./scripts/aws_artifact_build 4
./scripts/aws_artifact_upload dmc-devops-code mario 4.zip
./scripts/aws_codedeploy_deployment draft-demo3-cd draft-demo3-dg dmc-devops-code mario 4.zip
```

### Deploy from Jenkins:
Create a jenkins job using Jenkinsfile
