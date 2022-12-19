// Bellanov L.L.C

resource "random_string" "env_suffix" {
  length  = 4
  upper   = false
  special = false
}

// Billing Account ($$$)
data "google_billing_account" "acct" {
  display_name = var.billing_account
  open         = true
}

// Deployment
module "deployment" {
  source   = "../../modules/tf_deployment"
  for_each = local.projects_manifest


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