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
  vpcs    = local.network.vpcs
  subnets = local.network.subnets
}

module "application" {
  source = "../modules/application"
}

module "security" {
  source = "../modules/security"
}

# Locals
#
# Area to constrain / harness various configurations to modules / resources. 
#================================================

locals {
  region             = "us-east-1"
  availability_zones = ["us-east-1a", "us-east-1b"]

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

  network = {
    "vpcs" : {
      # Not made of money
      "Web VPC" : {
        "name" : "Web VPC",
        "cidr_block" : "192.168.100.0/24"
      }
    },
    "subnets" : {
      # "Web Subnet 1" : {
      #   "vpc_id" : "someting",
      #   "cidr_block" : cidrsubnet("192.168.100.0/24", 2, 0),
      #   "availability_zone" : local.availability_zones[0]
      # },
      # "Web Subnet 2" : {
      #   "vpc_id" : "someting",
      #   "cidr_block" : cidrsubnet("192.168.100.0/24", 2, 1),
      #   "availability_zone" : local.availability_zones[1]
      # },
    },
    "public_subnets" : {}
  }

  application = {
    "ami_ids" : {
      "us-east-1" : "ami-97785bed"
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

