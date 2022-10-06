Pasos:
1. Conectar aws cli:
```
aws configure
```

2. Modificar el keypair en el archivo variables.tf linea 17
3. Modificar el nro de instancias a crear en variables.tf linea 22
4. Inicializar y hacer un plan:
```
terraform init
terraform plan
```
4. Aplicar y ver IPs:
```
terraform apply
terraform output
```

5. Destruir las instancias:
```
terraform destroy
```
