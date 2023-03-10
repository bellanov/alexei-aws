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

// Logs
module "storage" {
  source   = "../modules/storage"
  for_each = local.manifest
  environment = each.key
}

locals {
  region   = "us-east-1"

  manifest = {
    "dev" : {},
    "qa" : {},
    "prod" : {}
  }
}
