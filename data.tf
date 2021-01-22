data "aws_ami" "rhel8_latest" {
  most_recent = true
  owners      = ["309956199498"] # google the "red hat ami owner" and the first link where there is an redhat accound id: https://access.redhat.com/solutions/15356, and another link https://access.redhat.com/solutions/99333

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
