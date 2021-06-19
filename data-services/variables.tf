# --- RDS ---
variable "db_instance_type" {
  default = "db.t2.small"
}
variable "db_username" {
  type        = string
  sensitive = true
  default     = "admin"
}
variable "db_password" {
  type        = string
  sensitive = true
  default     = "adminadmin"
}

# --- INPUT ---
variable "db_subnet_group_name" {
  type        = string
}
variable "vpc_security_group_ids" {
  type        = list(string)
}
variable "availability_zone" {
  type        = list(string)
}