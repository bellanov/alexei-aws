
// Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.48.0"
    }
  }
}

// Deployment
module "deployment" {
  source   = "../../modules/tf_deployment"
  for_each = local.environments
  region = each.value.region

}

// Manifest
locals {

  environments = {
    "dev" : {
      "region" : "us-east-1"
    },
    "test" : {
      "region" : "us-east-1"
    },
    "prod" : {
      "region" : "us-east-1"
    }
  }

}