output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.centos_instance.id
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.centos_instance.public_ip
}

output "private_key_file" {
  description = "Path to the generated private key"
  value       = local_file.private_key_pem.filename
}

