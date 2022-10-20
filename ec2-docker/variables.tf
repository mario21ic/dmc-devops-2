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

variable "cantidad" {
  default = 1
  description = "number of instances"
}

