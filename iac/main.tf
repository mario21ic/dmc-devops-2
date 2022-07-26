provider "aws" {
  region = "${var.region}"
}

module "codedeploy" {
  //source                = "github.com/mario21ic/terraform-aws-codedeploy"
  source                = "./tfmodules/aws-codedeploy"

  region                = "${var.region}"
  //env                   = "${terraform.workspace}"
  env                   = "draft"
  name                  = "demo3"
  ec2_key               = "Alo2"

  //ec2_filter_key        = "Name"
  //ec2_filter_value      = "${terraform.workspace}-demo"
  ec2_filter_value      = "draft-demo3-123"
}
