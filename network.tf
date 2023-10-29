# Crear una dirección IP elástica para asociarla con la instancia EC2
resource "aws_eip" "web_eip" {
  instance = aws_instance.web.id
}
resource "aws_eip_association" "eip_assoc" {
  instance_id = aws_instance.web.id
  allocation_id = aws_eip.web_eip.id
}

# Crear un grupo de seguridad que permita el tráfico SSH entrante y saliente

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id
ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 

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
