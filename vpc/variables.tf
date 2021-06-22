# --- VPC ---
variable "vpc_cidr" {
  default = "10.20.0.0/16"
}
variable "public_subnet_cidr" {
  type    = list(string)
  default = [
    "10.20.1.0/24",
    "10.20.2.0/24"
  ]
}
variable "private_subnet_cidr" {
  type    = list(string)
  default = ["10.20.11.0/24", "10.20.12.0/24"]
}
variable "data_subnet_cidr" {
  type    = list(string)
  default = ["10.20.101.0/24", "10.20.102.0/24"]
}

# --- INPUT ---
variable "region" {
  type = string
}
variable "availability_zone" {
  type = list(string)
}