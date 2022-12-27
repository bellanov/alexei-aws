
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.48.0"
    }
  }
}

provider "aws" {
  region = var.region
}

// Deployment
module "deployment" {
  source   = "../../modules/tf_deployment"
  for_each = local.environments


}

locals {
  display_name           = "Development_1"
  
  environments = {
    "dev" : {
      "region": "test"
    },
    "test" : {
      "region": "test"
    },
    "prod" : {
      "region": "test"
    }
  }
}