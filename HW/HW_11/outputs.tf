output "instance_public_ip" {
  description = "Public IP of the WordPress instance"
  value       = aws_instance.wordpress.public_ip
}
