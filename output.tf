# Salidas para mostrar información útil después de la creación de los recursos

output "ip_instance" {
  value = "Este es ${aws_instance.web.public_ip}"
}

output "ssh" {
  value = "ssh -l ubuntu ${aws_instance.web.public_ip}"
}
