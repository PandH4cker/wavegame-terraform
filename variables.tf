# Variables globales
variable "region" {
  default = "eu-west-3"
}

variable "availability_zone" {
  type = list(string)
  default = ["eu-west-3a", "eu-west-3b"]
}

# -- RDS --
variable "db_instance_type" {
  default = "db.t2.micro"
}

variable "db_username" {
  type        = string
  default     = "admin"
}

variable "db_password" {
  type        = string
  default     = "adminadmin"
}
