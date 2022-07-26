data "aws_ami" "amazonv2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "ec2_draft" {
  ami                    = "${data.aws_ami.amazonv2.id}"
  instance_type          = "t2.nano"
  key_name               = "${var.ec2_key}"
  vpc_security_group_ids = ["${aws_security_group.sg_draft.id}"]
  associate_public_ip_address = true
  iam_instance_profile = "${aws_iam_instance_profile.instance_profile.id}"

  #count = 3
  count = 1

  tags = {
    Name        = "${local.name_prefix}-ec2"
    cd_ec2_tag  = var.ec2_filter_value
    Enviroment  = "${var.env}"
    Description = "Server application"
  }
}

resource "aws_security_group" "sg_draft" {
  name        = "${local.name_prefix}-sg"
  description = "Server application inbound and outbound"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Enviroment  = "${var.env}"
    Description = "Server application security group"
  }
}
