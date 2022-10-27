variable "region" {
  description = "aws region"
  default     = "us-east-2"
}

variable "env" {
  default = "draft"
  description = "Environment name"
}

variable "name" {
  default = "demo"
  description = "Name ec2"
}

variable "key_name" {
  default = "Alo2"
  description = "key pair name"
}

variable "ec2_type" {
  //default = "t3.nano"
  default = "t3.medium"
  description = "ec2 instance type"
}

variable "cantidad" {
  default = 1
  description = "number of instances"
}

