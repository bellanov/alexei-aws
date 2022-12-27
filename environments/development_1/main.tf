
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

locals {

  environments = {
    "dev" : {
      "region" : "test"
    },
    "test" : {
      "region" : "test"
    },
    "prod" : {
      "region" : "test"
    }
  }

}