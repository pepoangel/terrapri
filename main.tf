
# Crear un par de claves SSH para acceder a las instancias

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.SSH_KEY_PUB
}

# Crear una instancia EC2 utilizando la AMI de Ubuntu, el tipo de instancia, la clave SSH y el grupo de seguridad

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.nano"
  key_name      = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id
  ]
  tags = {
    Name = "LinuxDO"
  }
}
