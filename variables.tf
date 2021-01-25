variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "ec2_instance_type" {
  description = "AWS EC2 instance type."
  type        = string
  default     = "t2.micro"
}

variable "instance_count" {
  description = "Number of instances to provision."
  type        = number
  default     = 1
}

variable "ebs_volume" {
  description = "EBS volume values"
  type = object({
    type        = string
    size        = number
    device_name = string
  })
  default = {
    type        = "gp2"
    size        = 2
    device_name = "/dev/xvdb"
  }
}

variable "public_key" {
  description = "Public key for access via ssh"
  type        = map(string)
  default = {
    name = "Ales.Soikin@itechart-group.com"
    key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCXl2yWOAQMVRZ9QGPlr9EOmc9CA3Sxt7IJUf7mXoRnkGlt6/o99ofdJ/IqKz3LHtfHjvkvpbpFHDxZ/0hwxIxO+MckWuGAYTPwk6gsPQBAwI406m/7X2Y2wrx0uwl6yy7VEk22E6sVKQGKYj9o8ZTeQp+n5MdmJnEzApJrkr+lTCRqAT0TWRjfSBiztx6rOHOgFI5jVT19gK6KOKyS5aHiY/BLW7NBcjdVdiU0pwFXcI1j4pb+XsYm4tZfyL52Sc8bzS2m48R2+p8DvwZyM0oWPDLcUs8BwkhSAtycPeJVSDNugwsTXKOq9tMZZ3RCQVCpEwYSxQe0m03d/pS5XEhU+2GBUOEqsO3OwxOlS180N2f7+8ueT1/sq0qE1WOHF30VyIn2LVaW3+FoX+UBRXLJjEhCnTNMNpR/cWNVxTDTYCi8IIlCPGywiPCEEdz/oKkB3ktKDTT6ZPboqgB/RayRMW08fk44GRtwO83cmoss+xqRqdLhgXfm25B+hR67CQrzkjoDydsGc+WaHcJGyiZHzO/ATOl9uXwVLdDE8aX5tUxciWkQdebmN7tuAT8eqk2HNHEFg5EUH/kl8b+JeQzy3qpv9R+hDBHbCuZ5DtG7It1YFeR56GiZwO8KYTUsqQ7Y6YSspcqdynWGbSoGLoJkWlNelbOiPo78EKd/YyLLmQ== Ales.Soikin@itechart-group.com"
  }
}

variable "source_cidr" { # Needs to be defined in terraform.tfvars
  description = "Source cids for access via ssh"
  type        = string
}

variable "vpc_id" { # Needs to be defined in terraform.tfvars
  description = "vpc id"
  type        = string
}
