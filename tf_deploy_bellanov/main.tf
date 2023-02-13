terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.50.0"
    }
  }
}

provider "aws" {
  region      = local.region
}

module "storage" {
  source   = "../modules/storage"
  for_each = local.manifest
  project  = local.project
  location = local.location
}

locals {
  region   = "us-east1"

  manifest = {
    "dev" : {},
    "qa" : {},
    "prod" : {}
  }
}
