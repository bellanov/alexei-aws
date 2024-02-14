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

module "role" {
  source = "../modules/role"
}

module "build" {
  source = "../modules/build"
  builds = local.builds
  artifacts_bucket = local.build_config.artifacts_bucket
  codebuild_service_role = local.build_config.codebuild_service_role
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
    "us-east-1" : "ami-0a3c3a20c09d6f377",
    "us-west-2" : "ami-0fb83677"
  }

  storage = {
    "buckets" : {
      "codepipeline" : {
        "description" : "CodePipeline Artifacts.",
      },
      "testing" : {
        "description" : "Testing Results.",
      },
      "releases" : {
        "description" : "Build Artifacts.",
      }
    }
  }

  build_config = {
    "artifacts_bucket" : "artifact-bucket",
    "codebuild_service_role" : "arn:aws:iam::636334826710:role/codebuild"
  }

  builds = {
    "react-template" : {
      "description" : "Template for React development.",
      "location" : "https://github.com/bellanov/react-template.git"
    }
  }

  vpcs = {
    # "Bellanov VPC" : {
    #   "name" : "Bellanov VPC",
    #   "cidr_block" : "10.0.0.0/16"
    # },
    # "Aktos VPC" : {
    #   "name" : "Aktos VPC",
    #   "cidr_block" : "11.0.0.0/16"
    # },
    # "YSL VPC" : {
    #   "name" : "YSL VPC",
    #   "cidr_block" : "12.0.0.0/16"
    # },
    # "Louis Vuitton VPC" : {
    #   "name" : "Louis Vuitton VPC",
    #   "cidr_block" : "13.0.0.0/16"
    # },
    # "Victoria's Secret VPC" : {
    #   "name" : "Victoria's Secret VPC",
    #   "cidr_block" : "14.0.0.0/16"
    # }
  }

  subnets = {
    # "Bellanov - Public Subnet 1" : {
    #   "vpc_id" : module.network.vpcs["Bellanov VPC"].id,
    #   "cidr_block" : cidrsubnet(local.vpcs["Bellanov VPC"].cidr_block, 2, 2),
    #   "availability_zone" : local.availability_zones[0]
    # },
    # "Bellanov - Public Subnet 2" : {
    #   "vpc_id" : module.network.vpcs["Bellanov VPC"].id,
    #   "cidr_block" : cidrsubnet(local.vpcs["Bellanov VPC"].cidr_block, 2, 3),
    #   "availability_zone" : local.availability_zones[1]
    # }
  }

  internet_gateways = {
    # "Bellanov IGW" : {
    #   vpc_id : module.network.vpcs["Bellanov VPC"].id
    # }
  }

  public_routes = {
    # "Bellanov VPC" : {
    #   "vpc_id" : module.network.vpcs["Web VPC"].id,
    #   "igw_id" : module.network.internet_gateways["Web IGW"].id
    # }
  }

  route_table_associations = {
    # "Public Subnet 1" : {
    #   "subnet_id" : module.network.subnets["Public Subnet 1"].id,
    #   "route_table_id" : module.network.public_routes["Web VPC"].id
    # },
    # "Public Subnet 2" : {
    #   "subnet_id" : module.network.subnets["Public Subnet 2"].id,
    #   "route_table_id" : module.network.public_routes["Web VPC"].id
    # }
  }

  aws_instances = {
    # "Web Server 1" : {
    #   "ami" : local.ami_ids["us-east-1"],
    #   "instance_type" : "t2.micro",
    #   "subnet_id" : module.network.subnets["Web Subnet 1"].id,
    #   "user_data" : file("get_instance_id.sh"),
    #   "security_group_ids" : [aws_security_group.web_sg.id]
    # }
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
