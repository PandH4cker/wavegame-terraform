# --- EC2 ---
variable "ami" {
  type = map(string)
  default = {
    eu-west-1 = "ami-099a8245f5daa82bf"
    eu-west-2 = "ami-0389b2a3c4948b1a0"
    eu-west-3 = "ami-0fd9bce3a3384b635"
  }
  description = "Amazon Linux 2 AMI (HVM)"
}
variable "instance_type" {
  default = "t2.micro"
}

# --- INPUT ---
variable "region" {
  type = string
}
variable "availability_zone" {
  type = list(string)
}

# From VPC
variable "vpc_security_group_ids" {
  type = list(string)
}
variable "public_subnet_id" {
  type = string
}
variable "private_subnet_id" {
  type = string
}

# From IAM
variable "ec2_instance_profile" {
  type = string
}

# From Data-services
variable "application_code_bucket_id" {
  type = string
}
variable "application_code_1_object" {
  type = map(string)
}
variable "application_code_2_object" {
  type = map(string)
}
variable "first_rds_endpoint" {
  type = string
}
variable "second_rds_endpoint" {
  type = string
}