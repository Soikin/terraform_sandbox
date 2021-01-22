terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.aws_region
}

resource "aws_key_pair" "pub_key" {
  key_name   = var.public_key["name"]
  public_key = var.public_key["key"]
}

data "aws_ami" "rhel8_latest" {
  most_recent = true
  owners = ["309956199498"] # google the "red hat ami owner" and the first link where there is an redhat accound id: https://access.redhat.com/solutions/15356, and another link https://access.redhat.com/solutions/99333

  filter {
    name   = "architecture"
    values = ["x86_64"] # RedHat also has arm images
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "name"
    values = ["RHEL-8*"]
  }
}

resource "aws_instance" "ec2_instance" {
  ami           = data.aws_ami.rhel8_latest.id
  instance_type = var.ec2_instance_type
  key_name      = var.public_key["name"]
  # user_data     = file("init.sh")
  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf clean all -y
    EOF
}

resource "aws_ebs_volume" "volume" {
  availability_zone = aws_instance.ec2_instance.availability_zone
  type              = var.ebs_volume.type
  size              = var.ebs_volume.size
}

resource "aws_volume_attachment" "volume_attachment" {
  device_name = var.ebs_volume.device_name
  instance_id = aws_instance.ec2_instance.id
  volume_id   = aws_ebs_volume.volume.id
}
