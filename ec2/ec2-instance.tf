# Ec2 instance for the first application
resource "aws_instance" "first_zone_1" {
  ami                    = var.ami[var.region]
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [
    var.vpc_security_group_ids[0],
    var.vpc_security_group_ids[1],
    var.vpc_security_group_ids[2]
  ]
  key_name               = aws_key_pair.this.key_name
  // Commands run at launch
  user_data              = templatefile("${path.module}/userdata/ec2-userdata-1.sh", {
                              application_code_bucket_id = var.application_code_bucket_id
                              application_code_1_object = var.application_code_1_object
                              first_rds_endpoint = var.first_rds_endpoint
                              second_rds_endpoint = var.second_rds_endpoint
                          })
  iam_instance_profile   = var.ec2_instance_profile
  tags = {
    Name = "First application ec2 zone 1"
  }
}

# Ec2 instance for the second application
resource "aws_instance" "second_zone_1" {
  ami                    = var.ami[var.region]
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [
    var.vpc_security_group_ids[0],
    var.vpc_security_group_ids[1],
    var.vpc_security_group_ids[3]
  ]  
  key_name               = aws_key_pair.this.key_name
  // Commands run at launch
  user_data              = templatefile("${path.module}/userdata/ec2-userdata-2.sh", {
                              application_code_bucket_id = var.application_code_bucket_id
                              application_code_2_object = var.application_code_2_object
                              first_rds_endpoint = var.first_rds_endpoint
                              second_rds_endpoint = var.second_rds_endpoint
                          })
  iam_instance_profile   = var.ec2_instance_profile
  tags = {
    Name = "Second application ec2 zone 1"
  }
}

# Keypair to access to ec2 instances with ssh
resource "aws_key_pair" "this" {
  key_name   = "ec2_ssh_key"
  public_key = file("${path.module}/keypair/id_rsa.pub")
}
