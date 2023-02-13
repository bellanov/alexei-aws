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
}

// CodeBuild
module "build" {
  source   = "../modules/storage"
  for_each = local.manifest
}

// Logs
module "storage" {
  source   = "../modules/storage"
  for_each = local.manifest
}

locals {
  region   = "us-east1"

  manifest = {
    "dev" : {},
    "qa" : {},
    "prod" : {}
  }
}
