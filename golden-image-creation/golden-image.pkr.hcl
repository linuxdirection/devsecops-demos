packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1.1.1"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1.0.0"
    }
  }
}

variable "aws_region" {
  default = "eu-west-1"
}

variable "source_ami" {
  default = "ami-0d0fa503c811361ab"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "ami_name" {
  default = "packer-testing-{{timestamp}}"
}

variable "vpc_id" {
  default = "vpc-02e73f9d2f7583bdc"
}

variable "subnet_id" {
  default = "subnet-0af7f59cadc67246e"
}

source "amazon-ebs" "example" {
  region                      = var.aws_region
  source_ami                  = var.source_ami
  instance_type               = var.instance_type
  ssh_username                = "ubuntu"
  vpc_id                      = var.vpc_id
  subnet_id                   = var.subnet_id
  ami_name                    = var.ami_name
  associate_public_ip_address = true
  run_tags = {
    Name = "packer-example"
  }

  tags = {
    Name = "packer-example"
  }
}

build {
  sources = ["source.amazon-ebs.example"]

  provisioner "ansible" {
    playbook_file = "./playbook.yml"
    extra_arguments = [
      "--ssh-extra-args", "-o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedKeyTypes=+ssh-rsa"
    ]
  }

  provisioner "file" {
    source      = "inspec_profile"
    destination = "/tmp/inspec_profile"
  }

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y ruby ruby-dev",
      "sudo gem install inspec -v 5.0.0"
    ]
  }


  provisioner "shell" {
    inline = [
      "export CHEF_LICENSE=accept",
      "inspec exec /tmp/inspec_profile"
    ]
  }
}
