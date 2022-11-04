# dmc-codedeploy

Requisitos:
- Packer 1.7.4
- Terraform 1.2.2
- Aws cli

Instalar Dependencias:
```
wget https://releases.hashicorp.com/packer/1.8.2/packer_1.8.2_linux_amd64.zip -O packer.zip
unzip packer.zip
sudo mv packer /usr/local/bin/

wget https://releases.hashicorp.com/terraform/1.2.5/terraform_1.2.5_linux_amd64.zip -O terraform.zip
unzip terraform.zip
sudo mv ./terraform /usr/local/bin/

sudo apt install awscli -y
```

Configurar:
```
$ aws configure
aws credentials:
aws access:
region: us-east-2
```

### Aws Ami:
```
cd amis/nginx/
./build.sh
# Anotar el ami id para usar en terraform

cd amis/jenkins/
./build.sh
# Anotar el ami id para usar en terraform
```

### Infrastructure as Code:
```
cd iac/
# De ser necesario CAMBIAR los valores como name en terraform.tfvars
./terraform_apply.sh
```

Para eliminar:
```
./terraform_destroy.sh
```

Instalar para TODOS los recursos de los alumnos:
```
./instalar_todos.sh
```
Se creara una carpeta por cada alumno.
Para remover todos los recursos de los alumnos:
```
./remover_todos.sh
```

### Deploy from localhost:
```
./scripts/aws_artifact_build 4
./scripts/aws_artifact_upload dmc-devops-code mario 4.zip
./scripts/aws_codedeploy_deployment draft-demo3-cd draft-demo3-dg dmc-devops-code mario 4.zip
```

### Deploy from Jenkins:
Create a jenkins job using Jenkinsfile
