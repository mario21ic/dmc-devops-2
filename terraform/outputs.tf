output "codedeploy_app_id" {
  value = "${module.codedeploy.codedeploy_app_id}"
}

output "codedeploy_group_id" {
  value = "${module.codedeploy.codedeploy_group_id}"
}

output "codedeploy_role_name" {
  value = "${module.codedeploy.codedeploy_role_name}"
}
output "codedeploy_policy_name" {
  value = module.codedeploy.codedeploy_policy_name
}

output "ec2_instance_policy_name" {
  value = module.codedeploy.ec2_instance_policy_name
}

output "ec2_deploy_public_ip" {
  value = module.ec2.ec2_instance_public_ip
}

output "ec2_jenkins_public_ip" {
  value = aws_instance.ec2_jenkins.public_ip
}

