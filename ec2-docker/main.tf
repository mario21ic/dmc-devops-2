locals {
  //command = "aws ssm start-session --target ${aws_instance.proxy.id} --region ${var.region}"
  name_prefix = "${var.env}-${var.name}"
}

data "aws_ami" "ubuntu2204" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "ec2_draft" {
  ami                    = "${data.aws_ami.ubuntu2204.id}"
  instance_type          = "t2.nano"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.sg_draft.id}"]
  associate_public_ip_address = true

  count = var.cantidad

  tags = {
    Name        = "${local.name_prefix}-ec2-${count.index}"
    Enviroment  = "${var.env}"
    Description = "DMC devops example"
  }

  // Install wget git and docker
  connection {
      host      = self.public_ip
      user      = "ubuntu"
      type      = "ssh"
      private_key = file("${path.root}/${var.key_name}.pem")
      timeout   = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt update",
      "sudo apt install apt-transport-https ca-certificates curl software-properties-common -y",
      "curl -sSL https://get.docker.com | sudo sh",
      "sudo usermod -aG docker ubuntu",
      "sudo systemctl start docker",
      "sudo systemctl enable docker"
    ]
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

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
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

