# When you declare a variable in child modules, the calling module should pass values in the module block as an input.
module "secrets" {
  source = "./secrets"
}

# VPC : network resources
module "vpc" {
  source = "./vpc"

  region            = var.region
  availability_zone = var.availability_zone

  log_bucket_arn = module.data-services.log_bucket.arn
}

# IAM : user and access management resources
module "iam" {
  source = "./iam"

  application_code_bucket_arn = module.data-services.application_code_bucket_arn
}

# Data-Services : storage resources
module "data-services" {
  source = "./data-services"

  region = var.region

  db_subnet_group_name    = module.vpc.db_subnet_group_name
  vpc_security_group_ids  = [
    module.vpc.allow_mysql_sg_id,
    module.vpc.allow_mssql_sg_id
  ]
  availability_zone = var.availability_zone

  db_username = module.secrets.db_creds.username
  db_password = module.secrets.db_creds.password
}

# EC2 : computing resources
module "ec2" {
  source = "./ec2"

  region                  = var.region
  availability_zone       = var.availability_zone

  log_bucket_name = module.data-services.log_bucket.bucket

  main_vpc_id = module.vpc.main_vpc_id
  vpc_security_group_ids  = [
    module.vpc.allow_http_sg_id,
    module.vpc.allow_tls_sg_id,
    module.vpc.allow_mysql_sg_id,
    module.vpc.allow_mssql_sg_id,
    module.vpc.allow_ssh_sg_id
  ]
  public_subnet_ids        = module.vpc.public_subnet_ids
  private_subnet_ids       = [
    module.vpc.private_subnet_ids[0],
    module.vpc.private_subnet_ids[1]
  ]

  ec2_instance_profile    = module.iam.ec2_instance_profile

  application_code_bucket_id   = module.data-services.application_code_bucket_id
  application_code_1_object    = module.data-services.application_code_1_object
  application_code_2_object    = module.data-services.application_code_2_object
  first_rds_endpoint           = module.data-services.first_rds_endpoint
  second_rds_endpoint          = module.data-services.second_rds_endpoint
  db_username = module.secrets.db_creds.username
  db_password = module.secrets.db_creds.password
}

# CloudTrail Alarm Root Login AWS Account
module "cloudtrail" {
  source = "./cloudtrail"

  region = var.region
}

# Lambda RDS Logs to S3
module "lambda-rds-s3" {
  source = "./lambda-rds-s3"

  memory_size = var.memory_size
  timeout = var.timeout
}

# CloudWatch RDS Logs to S3
module "cloudwatch-rds-s3" {
  source = "./cloudwatch-rds-s3"

  region = var.region
  
  lambda_function_arn = module.lambda-rds-s3.lambda_function_arn
  lambda_function_name = module.lambda-rds-s3.lambda_function_name
  rate = var.rate
  rds_instance_names = [
    module.data-services.rds_instance_names[0],
    module.data-services.rds_instance_names[1]
  ]
  s3_bucket_name = module.data-services.log_bucket.bucket
  min_file_size = var.min_file_size
  log_prefix = var.log_prefix
}