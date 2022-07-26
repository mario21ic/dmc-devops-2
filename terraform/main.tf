provider "aws" {
  region = "${var.region}"
}

// Codedeploy
module "codedeploy" {
  source                = "./tfmodules/aws-codedeploy"

  region                = "${var.region}"
  //env                   = "${terraform.workspace}"
  env                   = var.env
  name                  = var.name

  //ec2_filter_value      = "${terraform.workspace}-demo"
  ec2_filter_value      = "${var.env}-${var.name}-123"
}

module "ec2" {
  source                = "./tfmodules/aws-ec2"
  depends_on            = [module.codedeploy]

  region                = "${var.region}"
  //env                   = "${terraform.workspace}"
  env                   = var.env
  name                  = var.name
  key_name              = var.key_name
  instance_profile      = "${module.codedeploy.ec2_instance_profile_id}"

  //ec2_filter_key        = "Name"
  //ec2_filter_value      = "${terraform.workspace}-demo"
  ec2_filter_value      = "${var.env}-${var.name}-123"
}



// Jenkins
resource "aws_security_group" "jenkins_sg" {
  name        = "${var.env}-${var.name}-jenkins-sg"
  description = "Server jenkins inbound and outbound"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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

resource "aws_instance" "ec2_jenkins" {
  //ami                    = "ami-094f35ba45e1be4e8" # prev
  ami                    = "ami-02f3416038bdb17fb" # Ubuntu 20.04
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = ["${aws_security_group.jenkins_sg.id}"]
  associate_public_ip_address = true
  //iam_instance_profile = "${var.instance_profile}"
  //count = 1

  tags = {
    Name        = "${var.env}-${var.name}-jenkins"
    Enviroment  = var.env
    Description = "Jenkins server application"
  }

  // Install jenkins and docker
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
      "sudo apt install apt-transport-https ca-certificates curl software-properties-common openjdk-11-jre -y",
      "curl -sSL https://get.docker.com | sudo sh",
      "sudo usermod -aG docker ubuntu",
      "sudo usermod -aG docker jenkins",
      "curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null",
      "echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
      "sudo apt update",
      "sudo apt-get install jenkins -y",
      "sudo systemctl restart jenkins",
      "sudo systemctl enable jenkins",
      "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
    ]
  }
}
