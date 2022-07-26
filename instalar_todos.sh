#!/bin/bash
set -e

echo "## DMC script"
WORKDIR=$PWD
array=( alumno1 alumno2 )
for alumno in "${array[@]}"
do
    echo "######### $alumno"
    git clone https://github.com/mario21ic/dmc-codedeploy.git $alumno
    cd $alumno/terraform
    #cp ~/Alo2.pem ./
    terraform init
    terraform apply -var="name=$alumno" -auto-approve
    read  -n 1 -p "COPIAR Codedeploy nombres y EC2 IP Publicas del $alumno. Presionar ENTER para continuar" rpta
    echo $rpta
    echo $PWD
    cd $WORKDIR
done


