access_key         = "your_aws_access_key"
secret_key         = "your_aws_secret_key"
defaul_region      = "us-east-2"

prod_vpc_cidrs     = ["10.10.0.0/16"]
subnet_prod_vpc_2  = [{cidr_block = "10.10.1.0/24", name = "prod-10.10.1.0-24"}]

prod_2_vpc_name            = "prod_vpc_2"
prod_2_route_table_cidr_v4 = "0.0.0.0/0"
prod_2_route_table_cidr_v6 = "::/0"

web_server_02_nic_ips = ["10.10.1.100"]

us_east_2_ec2_ubuntu_ami   = "ami-0283a57753b18025b"
us_east_2_ec2_ubuntu_size  = "t2.nano" # "t2.micro" #"t2.nano"
us_east_2_ec2_key_name     = "ohio-demo-keypair"
us_east_2_ec2_ubuntu_az    = "us-east-2b"

us-east-2-az = ["us-east-2b"]
