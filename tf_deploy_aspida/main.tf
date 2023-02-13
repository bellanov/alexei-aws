// Bellanov L.L.C.

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.54.0"
    }
  }
}

provider "aws" {
  region      = local.region
  access_key = var.access-key
  secret_key = var.secret-key
}

// CodeBuild
module "build" {
  source   = "../modules/build"
}

// Logs
module "storage" {
  source   = "../modules/storage"
  for_each = local.environment
  environment = each.key
}

locals {
  region   = "us-east1"

  environment = {
    "preprod" : {},
    # "testing" : {},
    # "staging" : {},
    # "uat" : {},
    "production" : {}
  }
}
