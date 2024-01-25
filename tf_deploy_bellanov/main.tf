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
  source  = "../modules/network"
  vpcs    = local.vpcs
  subnets = local.subnets
}

module "security" {
  source = "../modules/security"
}

module "application" {
  source = "../modules/application"
  aws_instances = local.aws_instances

  depends_on = [ module.network ]
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
      "vpc_id" : module.network.vpcs["Web VPC"].id ,
      "cidr_block" : cidrsubnet(local.vpcs["Web VPC"].cidr_block, 2, 0),
      "availability_zone" : local.availability_zones[0]
    },
    "Web Subnet 2" : {
      "vpc_id" : module.network.vpcs["Web VPC"].id,
      "cidr_block" : cidrsubnet(local.vpcs["Web VPC"].cidr_block, 2, 1),
      "availability_zone" : local.availability_zones[1]
    }
  }

  public_subnets = {}

  aws_instances = {
    "Web Server 1" : {
      "ami": local.ami_ids["us-east-1"],
      "instance_type": "t2.micro",
      "subnet_id": module.network.subnets["Web Subnet 1"].id,
      "user_data" : file("${path.module}/data/get_instance_id.sh")
    },
    "Web Server 2" : {
      "ami": local.ami_ids["us-east-1"],
      "instance_type": "t2.micro",
      "subnet_id": module.network.subnets["Web Subnet 2"].id,
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

