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
  source = "../modules/network"
}

# module "security" {
#   source             = "../modules/security"
#   service_accounts   = local.security.service_accounts
#   terraform_identity = local.security.terraform_identity
# }

# Locals
#
# Area to constrain / harness various configurations to modules / resources. 
#================================================

locals {
  region = "us-east-1"

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

  security = {
    "service_accounts" : {}
  }

  cloud_run_config = {
    "location" : "us-central1"
  }

  environments = {
    # Development
    "dev" : {
      "cloud_run_services" : {
        "editor" : {
          "image" : "us-central1-docker.pkg.dev/docker-releases/poc-editor:0.1.1"
        },
        "renderer" : {
          "image" : "us-central1-docker.pkg.dev/docker-releases/poc-renderer:0.1.1"
        }
      }
    },
    # Quality Assurance
    "qa" : {
      "cloud_run_services" : {
        "editor" : {
          "image" : "us-central1-docker.pkg.dev/docker-releases/poc-editor:0.1.1"
        },
        "renderer" : {
          "image" : "us-central1-docker.pkg.dev/docker-releases/poc-renderer:0.1.1"
        }
      }
    },
    # Production
    "prod" : {
      "cloud_run_services" : {
        "editor" : {
          "image" : "us-central1-docker.pkg.dev/docker-releases/poc-editor:0.1.1"
        },
        "renderer" : {
          "image" : "us-central1-docker.pkg.dev/docker-releases/poc-renderer:0.1.1"
        }
      }
    }
  }
}

# Resources
#
# Deploy things that were too annoying to put in a module.
#================================================

