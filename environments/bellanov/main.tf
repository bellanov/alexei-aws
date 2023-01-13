
// Deployment
module "deployment" {
  source   = "../../modules/tf_deployment"
  for_each = local.environments

  availability_zones = each.value.availability_zones
  cidr_block         = each.value.cidr_block
  key_name         = each.value.key_name
  bastion_instance_type         = each.value.bastion_instance_type
  app_instance_type = each.value.app_instance_type
  db_instance_type = each.value.db_instance_type
  workstation_ip = each.value.workstation_ip
  

  # key_name              = "cloudacademydemo"
  # bastion_instance_type = "t3.micro"
  # app_instance_type     = "t3.micro"
  # db_instance_type      = "t3.micro"


}

// Manifest
locals {
  environments = {
    "dev" : {
      "availability_zones" : ["us-west-2a", "us-west-2b"],
      "cidr_block"         : "10.0.0.0/16",
      "key_name"         : "cloudacademydemo",
      "bastion_instance_type" : "t3.micro",
      "app_instance_type" : "t3.micro",
      "db_instance_type" : "t3.micro",
      "workstation_ip": "70.130.77.2"
    }
  }

}