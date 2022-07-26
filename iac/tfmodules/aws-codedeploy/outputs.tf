output "codedeploy_app_id" {
  value = "${aws_codedeploy_app.cd_app.id}"
}

output "codedeploy_group_id" {
  value = "${aws_codedeploy_deployment_group.cd_app_group.id}"
}

output "codedeploy_role_name" {
  value = "${aws_iam_role.cd_role.name}"
}
output "codedeploy_policy_name" {
  value = "${aws_iam_role_policy.codedeploy_policy.name}"
}

output "ec2_instance_policy_name" {
  value = "${aws_iam_role_policy.ec2_instance_policy.name}"
}

output "ec2_instance_public_ip" {
  value = "${aws_instance.ec2_draft[0].public_ip}"
}
