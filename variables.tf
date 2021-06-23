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

variable "rate" {
  type = string
  default = "30 minutes"
}

variable "min_file_size" {
  type = number
  default = 0
}

variable "lifecycle_rule_enabled" {
  type = bool
  default = true
}

variable "expiration_days" {
  type = number
  default = 7
}

variable "log_prefix" {
  type = string
  default = "rds-logs"
}

variable "memory_size" {
  type = number
  default = 256
}

variable "timeout" {
  type = number
  default = 300
}