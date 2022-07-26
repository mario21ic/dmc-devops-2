provider "aws" {
  region = "${var.region}"
}

module "codedeploy" {
  source                = "./tfmodules/aws-codedeploy"

  region                = "${var.region}"
  //env                   = "${terraform.workspace}"
  env                   = "draft"
  name                  = "demo3"

  //ec2_filter_value      = "${terraform.workspace}-demo"
  ec2_filter_value      = "draft-demo3-123"
}

module "ec2" {
  source                = "./tfmodules/aws-ec2"
  depends_on            = [module.codedeploy]

  region                = "${var.region}"
  //env                   = "${terraform.workspace}"
  env                   = "draft"
  name                  = "demo3"
  key_name              = "Alo2"
  instance_profile      = "${module.codedeploy.ec2_instance_profile_id}"

  //ec2_filter_key        = "Name"
  //ec2_filter_value      = "${terraform.workspace}-demo"
  ec2_filter_value      = "draft-demo3-123"
}
