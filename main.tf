variable "vpc_id" {}
variable "region_name" {}
variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}
variable "SSH_KEY_PUB" {}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "image-id"
    values = ["ami-0a695f0d95cefc163"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.SSH_KEY_PUB
}

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
resource "aws_ebs_volume" "my_bucket" {
  availability_zone = var.availability_zone
  type  = "gp3"
  size = 10
  tags = {
    name = "my_bucket"
  }  
}
resource "aws_volume_attachment" "ebs_attachment" {
  device_name = "/dev/sdf" 
  volume_id   = aws_ebs_volume.my_bucket.id
  instance_id = aws_instance.web.id
}


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

output "ip_instance" {
  value = "Este es ${aws_instance.web.public_ip}"
}

output "ssh" {
  value = "ssh -l ubuntu ${aws_instance.web.public_ip}"
}
