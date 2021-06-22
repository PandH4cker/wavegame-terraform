# When you declare a variable in child modules, the calling module should pass values in the module block as an input.

# VPC : network resources
module "vpc" {
  source = "./vpc"

  region            = var.region
  availability_zone = var.availability_zone
}

# IAM : user and access management resources
module "iam" {
  source = "./iam"
}

# Data-Services : storage resources
module "data-services" {
  source = "./data-services"

  db_subnet_group_name    = module.vpc.db_subnet_group_name
  vpc_security_group_ids  = [
    module.vpc.allow_mysql_sg_id,
    module.vpc.allow_mssql_sg_id
  ]
  availability_zone = var.availability_zone
}

# EC2 : computing resources
module "ec2" {
  source = "./ec2"

  region                  = var.region
  availability_zone       = var.availability_zone

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
}

