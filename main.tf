# Variables

variable "vpc_id" {}
variable "region_name" {}
variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}
variable "SSH_KEY_PUB" {}

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

# Crear un par de claves SSH para acceder a las instancias

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.SSH_KEY_PUB
}

# Crear un grupo de seguridad que permita el tráfico SSH entrante y saliente

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id
 

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}



# Crear una instancia EC2 utilizando la AMI de Ubuntu, el tipo de instancia, la clave SSH y el grupo de seguridad

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id
  ]
  tags = {
    Name = "LinuxDO"
  }
}
# Salidas para mostrar información útil después de la creación de los recursos

output "ip_instance" {
  value = "Este es ${aws_instance.web.public_ip}"
}

output "ssh" {
  value = "ssh -l ubuntu ${aws_instance.web.public_ip}"
}
