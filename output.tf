output "kops-ip" {
  value = aws_instance.kops-server.public_ip
}

output "promgraf-ip" {
  value = aws_instance.promgraf-server.public_ip
}