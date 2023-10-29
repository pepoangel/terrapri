variable "vpc_id" {
  description = "ID de la VPC de AWS"
  type        = string
}

variable "region_name" {
  description = "Nombre de la región de AWS"
  type        = string
}

variable "AWS_ACCESS_KEY_ID" {
  description = "ID de acceso de AWS"
  type        = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "Clave secreta de acceso de AWS"
  type        = string
}

variable "SSH_KEY_PUB" {
  description = "Clave pública SSH"
  type        = string
}
