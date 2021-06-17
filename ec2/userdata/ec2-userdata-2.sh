#!/bin/bash
# Install webserver
sudo su
yum update -y
amazon-linux-extras install -y php7.3
yum -y install httpd

# Fetch the application code from the S3 bucket
aws s3 cp s3://${application_code_bucket_id}/${application_code_2_object.id} /var/www/html/index.php
# Force update when the object's etag change
echo ${application_code_2_object.etag}

# Define ressources variables
echo '<?php
$bucket_uri="${application_code_bucket_id}";
$sql_host_1="${first_rds_endpoint}";
$sql_host_2="${second_rds_endpoint}";
$sql_user="admin";
$sql_pwd="adminadmin";
?>' > /var/www/html/variables.php

# Install sqlsrv drivers
yum-config-manager --add-repo https://packages.microsoft.com/config/rhel/7/prod.repo
ACCEPT_EULA=Y yum install -y php msodbcsql mssql-tools unixODBC-devel php-devel php-pear php-pdo php-xml re2c gcc-c++ gcc
sudo pecl install sqlsrv
sudo pecl install pdo_sqlsrv
echo "extension=sqlsrv" >> /etc/php.ini
echo "extension=pdo_sqlsrv" >> /etc/php.d/30-pdo_sqlsrv.ini

sudo systemctl enable httpd
sudo systemctl start httpd