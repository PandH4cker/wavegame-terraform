variable "s3_bucket_name" {
  type = string
}
variable "lambda_function_name" {
  type = string
}
variable "lambda_function_arn" {
  type = string
}
variable "rds_instance_names" {
  type = list(string)
}
variable "rate" {
  type = string
}
variable "min_file_size" {
  type = number
}
variable "region" {
  type = string
}
variable "log_prefix" {
  type = string
}