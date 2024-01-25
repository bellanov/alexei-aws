// Bellanov L.L.C.

# Providers
# 
# Things to simply keep up-to-date...so you don't f*ck yourself over later.
#================================================
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }

  cloud {
    organization = "bellanov"
    workspaces {
      name = "aws_deploy_bellanov"
    }
  }
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = local.region
}

# Modules
#
# Any possibility of reusing "resource {}" blocks is attempted here.
#================================================

module "storage" {
  source  = "../modules/storage"
  buckets = local.storage.buckets
}

module "network" {
  source                   = "../modules/network"
  vpcs                     = local.vpcs
  subnets                  = local.subnets
  internet_gateways        = local.internet_gateways
  public_routes            = local.public_routes
  route_table_associations = local.route_table_associations
}

module "security" {
  source = "../modules/security"
}

module "application" {
  source        = "../modules/application"
  aws_instances = local.aws_instances

  depends_on = [module.network]
}

# Locals
#
# Area to constrain / harness various configurations to modules / resources. 
#================================================

locals {
  region             = "us-east-1"
  availability_zones = ["us-east-1a", "us-east-1b"]

  ami_ids = {
    "us-east-1" : "ami-97785bed",
    "us-west-2" : "ami-0fb83677"
  }

  storage = {
    "buckets" : {
      "testing" : {
        "description" : "Testing Results.",
      },
      "releases" : {
        "description" : "Build Artifacts.",
      }
    }
  }

  security = {}

  vpcs = {
    "Web VPC" : {
      "name" : "Web VPC",
      "cidr_block" : "192.168.100.0/24"
    }
  }

  subnets = {
    "Web Subnet 1" : {
      "vpc_id" : module.network.vpcs["Web VPC"].id,
      "cidr_block" : cidrsubnet(local.vpcs["Web VPC"].cidr_block, 2, 0),
      "availability_zone" : local.availability_zones[0]
    },
    "Web Subnet 2" : {
      "vpc_id" : module.network.vpcs["Web VPC"].id,
      "cidr_block" : cidrsubnet(local.vpcs["Web VPC"].cidr_block, 2, 1),
      "availability_zone" : local.availability_zones[1]
    },
    "Public Subnet 1" : {
      "vpc_id" : module.network.vpcs["Web VPC"].id,
      "cidr_block" : cidrsubnet(local.vpcs["Web VPC"].cidr_block, 2, 2),
      "availability_zone" : local.availability_zones[0]
    },
    "Public Subnet 2" : {
      "vpc_id" : module.network.vpcs["Web VPC"].id,
      "cidr_block" : cidrsubnet(local.vpcs["Web VPC"].cidr_block, 2, 3),
      "availability_zone" : local.availability_zones[1]
    }
  }

  internet_gateways = {
    "Web IGW" : {
      vpc_id : module.network.vpcs["Web VPC"].id
    }
  }

  public_routes = {
    "Web VPC" : {
      "vpc_id" : module.network.vpcs["Web VPC"].id,
      "igw_id" : module.network.internet_gateways["Web IGW"].id
    }
  }

  route_table_associations = {
    "Public Subnet 1" : {
      "subnet_id" : module.network.subnets["Public Subnet 1"].id,
      "route_table_id" : module.network.public_routes["Web VPC"].id
    },
    "Public Subnet 2" : {
      "subnet_id" : module.network.subnets["Public Subnet 2"].id,
      "route_table_id" : module.network.public_routes["Web VPC"].id
    }
  }

  aws_instances = {
    "Web Server 1" : {
      "ami" : local.ami_ids["us-east-1"],
      "instance_type" : "t2.micro",
      "subnet_id" : module.network.subnets["Web Subnet 1"].id,
      "user_data" : file("${path.module}/data/get_instance_id.sh")
    },
    "Web Server 2" : {
      "ami" : local.ami_ids["us-east-1"],
      "instance_type" : "t2.micro",
      "subnet_id" : module.network.subnets["Web Subnet 2"].id,
      "user_data" : file("${path.module}/data/get_instance_id.sh")
    }
  }

  environments = {
    # Development
    "dev" : {},
    # Quality Assurance
    "qa" : {},
    # Production
    "prod" : {}
  }
}

# Resources
#
# Deploy things that were too annoying to put in a module.
#================================================

# resource "aws_security_group" "elb_sg" {
#   name        = "ELB Security Group"
#   description = "Allow incoming HTTP traffic from the internet"
#   vpc_id      = "${aws_vpc.web_vpc.id}"
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   # Allow all outbound traffic
#   egress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
# resource "aws_security_group" "web_sg" {
#   name        = "Web Server Security Group"
#   description = "Allow HTTP traffic from ELB security group"
#   vpc_id      = "${aws_vpc.web_vpc.id}"
#   # HTTP access from the VPC
#   ingress {
#     from_port       = 80
#     to_port         = 80
#     protocol        = "tcp"
#     security_groups = ["${aws_security_group.elb_sg.id}"]
#   }
#   # Allow all outbound traffic
#   egress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }