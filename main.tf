resource "aws_key_pair" "pub_key" {
  key_name   = var.public_key["name"]
  public_key = var.public_key["key"]
  tags = merge(
    local.common_tags,
    {
      Name = "${local.environment_type}.${local.application_name}.pub-key"
    },
  )
}

resource "aws_security_group" "sg" {
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
  tags = merge(
    local.common_tags,
    {
      Name = "${local.environment_type}.${local.application_name}.sg"
    },
  )
}

resource "aws_instance" "ec2_instance" {
  count           = var.instance_count
  ami             = data.aws_ami.rhel8_latest.id
  instance_type   = var.ec2_instance_type
  key_name        = var.public_key["name"]
  security_groups = [aws_security_group.sg.name]
  user_data       = file("init.sh")
  depends_on = [
    aws_key_pair.pub_key,
    aws_security_group.sg
  ]
  tags = merge(
    local.common_tags,
    {
      Name = "instance-${count.index}.${local.company_domain}"
    },
  )
}

resource "aws_ebs_volume" "ebs_volume" {
  count             = var.create_volume ? var.instance_count : 0
  availability_zone = aws_instance.ec2_instance[count.index].availability_zone
  type              = var.ebs_volume.type
  size              = var.ebs_volume.size
  tags = merge(
    local.common_tags,
    {
      Name = "${local.environment_type}.${local.application_name}.ebs-volume"
    },
  )
}

resource "aws_volume_attachment" "volume_attachment" {
  count       = var.create_volume ? var.instance_count : 0
  device_name = var.ebs_volume.device_name
  instance_id = aws_instance.ec2_instance[count.index].id
  volume_id   = aws_ebs_volume.ebs_volume[count.index].id
  depends_on = [
    aws_instance.ec2_instance,
    aws_ebs_volume.ebs_volume
  ]
}
