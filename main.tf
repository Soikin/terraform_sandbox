resource "aws_key_pair" "pub_key" {
  key_name   = var.public_key["name"]
  public_key = var.public_key["key"]
  tags = {
    Name = "${local.setup_name}_pub_key"
  }
}

resource "aws_security_group" "allow_ssh" {
  name   = "allow-ssh"
  vpc_id = var.vpc_id
  ingress {
    cidr_blocks = [var.source_cidr]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_instance" {
  count           = var.instance_count
  ami             = data.aws_ami.rhel8_latest.id
  instance_type   = var.ec2_instance_type
  key_name        = var.public_key["name"]
  security_groups = [aws_security_group.allow_ssh.name]
  user_data       = file("init.sh")
  depends_on = [
    aws_key_pair.pub_key,
    aws_security_group.allow_ssh
  ]
  tags = {
    Name = "${local.setup_name}_ec2_instance"
  }
}

resource "aws_ebs_volume" "ebs_volume" {
  count             = var.instance_count
  availability_zone = aws_instance.ec2_instance[count.index].availability_zone
  type              = var.ebs_volume.type
  size              = var.ebs_volume.size
  tags = {
    Name = "${local.setup_name}_ebs_volume"
  }
}

resource "aws_volume_attachment" "volume_attachment" {
  count       = var.instance_count
  device_name = var.ebs_volume.device_name
  instance_id = aws_instance.ec2_instance[count.index].id
  volume_id   = aws_ebs_volume.ebs_volume[count.index].id
}
