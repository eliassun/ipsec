
variable "defaul_region" {
    type = string
}

variable "access_key" {
    type = string
}

variable "secret_key" {
    type = string
}

variable "prod_3_vpc_name" {
    type = string
}

variable "prod_vpc_cidrs" {
    type = list
}

variable "subnet_prod_vpc_3" {
    type = list
}

variable "subnet_prod_vpc_32" {
    type = list
}

variable "prod_3_route_table_cidr_v4" {
    type = string
}

variable "prod_3_route_table_cidr_v6" {
    type = string
}

variable "web_server_03_nic_ips" {
    type = list
}

variable "us_east_2_ec2_ubuntu_ami" {
    type = string
}

variable "us_east_2_ec2_ubuntu_size" {
    type = string
}

variable "us_east_2_ec2_key_name" {
    type = string
}

variable "us_east_2_ec2_ubuntu_az" {
    type = string
}

variable "us-east-2-az" {
    type = list
}

variable us-east-2-az2 {
    type = list
}

variable "us_east_2_ec2_ubuntu_az2" {
    type = string
}