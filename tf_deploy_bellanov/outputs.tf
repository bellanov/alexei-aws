
output "storage" {
  description = "Storage Module."
  value       = module.storage
}

output "network" {
  description = "Network Module."
  value       = module.network
}

output "application" {
  description = "Application Module."
  value       = module.application
}

output "security" {
  description = "Security Module."
  value       = module.security
}

# output "site_address" {
#   value = "${aws_elb.web.dns_name}"
# }