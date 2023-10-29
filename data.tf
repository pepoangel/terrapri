# Obtener información sobre la AMI de Ubuntu que será utilizada para la instancia EC2

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "image-id"
    values = ["ami-0f8e81a3da6e2510a"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}