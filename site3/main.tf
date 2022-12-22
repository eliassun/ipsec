# Create a network by Terraform
# github: https://github.com/eliassun/net4clouds

terraform {

}

# get my current public IP and keys

data "external" "local_env" {
  program = ["python3","local_env.py"]
  query = {
  }
}

# CSP is AWS
provider "aws" {
    region     = var.defaul_region
    access_key = var.access_key != "your_aws_access_key" ? var.access_key : data.external.local_env.result.aws_access_key
    secret_key = var.secret_key != "your_aws_secret_key" ? var.secret_key : data.external.local_env.result.aws_secret_key
}

# Create a VPC
resource "aws_vpc" "prod_vpc_3" {
    cidr_block = var.prod_vpc_cidrs[0]
    tags = {
        Name = "production-3"
    }
}

# Create an Internet Gateway

resource "aws_internet_gateway" "prod_internet_gw_3" {
    vpc_id = aws_vpc.prod_vpc_3.id
}

# Create a route table for the production network

resource "aws_route_table" "prod_route_table_3" {
    vpc_id = aws_vpc.prod_vpc_3.id
    route {
        cidr_block = var.prod_3_route_table_cidr_v4
        gateway_id = aws_internet_gateway.prod_internet_gw_3.id
    }
    route {
        ipv6_cidr_block = var.prod_3_route_table_cidr_v6
        gateway_id = aws_internet_gateway.prod_internet_gw_3.id
    }
    tags = {
        Name = "prod_3"
    }
}

# Create a subnet for the production network
resource "aws_subnet" "prod_vpc_3_subnet_3" {
    vpc_id            = aws_vpc.prod_vpc_3.id
    cidr_block        = var.subnet_prod_vpc_3[0].cidr_block
    map_public_ip_on_launch = true
    availability_zone = var.us_east_2_ec2_ubuntu_az
    tags = {
        Name = var.subnet_prod_vpc_3[0].name
    }
}

resource "aws_subnet" "prod_vpc_3_subnet_32" {
    vpc_id            = aws_vpc.prod_vpc_3.id
    cidr_block        = var.subnet_prod_vpc_32[0].cidr_block
    map_public_ip_on_launch = true
    availability_zone = var.us_east_2_ec2_ubuntu_az2
    tags = {
        Name = var.subnet_prod_vpc_32[0].name
    }
}

# Associate the production network subnet to routetable 

resource "aws_route_table_association" "prod_3_net_3" {
    subnet_id      = aws_subnet.prod_vpc_3_subnet_3.id
    route_table_id = aws_route_table.prod_route_table_3.id
}

resource "aws_route_table_association" "prod_3_net_32" {
    subnet_id      = aws_subnet.prod_vpc_3_subnet_32.id
    route_table_id = aws_route_table.prod_route_table_3.id
}

# Create security group

resource "aws_security_group" "prod_3_sg_3" {
    name        = "prod_3_sg_3"
    description = "production net-1 security-group-1"
    vpc_id      = aws_vpc.prod_vpc_3.id
    ingress {
        description = "IPSec-ISAKMP"
        from_port   = 500
        to_port     = 500
        protocol    = "udp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "IPSec-ESP"
        from_port   = 4500
        to_port     = 4500
        protocol    = "udp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${data.external.local_env.result.local_public_ip}/32"]      
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "prod-2-sg-1"
    }
}

# Create a network interface with an IP in the subnet 

resource "aws_network_interface" "web_server_nic_03" {
    subnet_id       = aws_subnet.prod_vpc_3_subnet_3.id
    private_ips     = var.web_server_03_nic_ips
    security_groups = [aws_security_group.prod_3_sg_3.id]
}

# Assign an elastic IP to the network interface created

resource "aws_eip" "web_server_eip_03" {
    vpc                       = true
    network_interface         = aws_network_interface.web_server_nic_03.id
    associate_with_private_ip = var.web_server_03_nic_ips[0]
    depends_on                = [aws_internet_gateway.prod_internet_gw_3]
}

# output elastic IP 
output "output_web_server_eip_03" {
    value = aws_eip.web_server_eip_03
} 

# Create an ubuntu ec2 and install apache2

resource "aws_instance" "test-server-ec2-03" {
    ami               = var.us_east_2_ec2_ubuntu_ami
    instance_type     = var.us_east_2_ec2_ubuntu_size
    availability_zone = var.us_east_2_ec2_ubuntu_az
    key_name          = var.us_east_2_ec2_key_name
    network_interface {
        device_index = 0
        network_interface_id = aws_network_interface.web_server_nic_03.id
    }
    #user_data = "${file("install_softwares.sh")}"
    tags = {
        Name = "test-server-ec2-02"
    }
}

# output the private ip of test-server-ec2-03

output "output-test-server-ec2-03-private-ip" {
    value = aws_instance.test-server-ec2-03.private_ip
}

# output the "server-id" of test-server-ec2-02

output "output-test-server-ec2-03-server-id" {
    value = aws_instance.test-server-ec2-03.id
}
