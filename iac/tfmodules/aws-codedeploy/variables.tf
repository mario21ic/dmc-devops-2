variable "region" {
  description = "aws region"
  default     = "us-east-2"
}

variable "env" {
  default = "draft"
  description = "Environment name"
}

variable "name" {
  description = "Name codedeploy"
}

variable "ec2_key" {
  description = "Name"
}

// TODO
#variable "ec2_filter_key" {
#  description = "Name"
#}

variable "ec2_filter_value" {
  description = "Name"
}

