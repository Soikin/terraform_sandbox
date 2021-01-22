output "public_ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "volume" {
  value = aws_volume_attachment.volume_attachment.device_name
}
