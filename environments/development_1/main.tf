
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
  regions = each.value.regions

}

// Manifest
locals {
  environments = {
    "dev" : {
      "regions" : {
        "us-east-1": {},
        "us-west-1": {},
        "us-central-1": {}
      }
    },
    "test" : {
      "regions" : {
        "us-east-1": {},
        "us-west-1": {},
        "us-central-1": {}
      }
    },
    "prod" : {
      "regions" : {
        "us-east-1": {},
        "us-west-1": {},
        "us-central-1": {}
      }
    }
  }

}