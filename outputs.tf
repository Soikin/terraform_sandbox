output "public_ip" {
  value = aws_instance.ec2_instance.*.public_ip
}

output "ebs_volume_device_name" {
  value = aws_volume_attachment.volume_attachment.*.device_name
}
