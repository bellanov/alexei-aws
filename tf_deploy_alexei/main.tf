// Alexei

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
      name = "aws_deploy_alexei"
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
}

# Locals
#
# Area to constrain / harness various configurations to modules / resources. 
#================================================

locals {
  region             = "us-west-1"
  availability_zones = ["us-west-1a", "us-west-1b"]

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

  vpcs = {}

  subnets = {}

  public_subnets = {}

  internet_gateways = {}

  public_routes = {}

  route_table_associations = {}

  aws_instances = {}

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

