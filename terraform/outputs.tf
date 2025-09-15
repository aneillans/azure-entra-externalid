output "id" {
  description = "The resource ID of the CIAM directory"
  value       = azapi_resource.ciam_directory.id
}

output "name" {
  description = "The name of the CIAM directory"
  value       = azapi_resource.ciam_directory.name
}

output "tenant_id" {
  description = "The tenant ID of the CIAM directory"
  value       = jsondecode(azapi_resource.ciam_directory.output).properties.tenantId
  sensitive   = true
}

output "domain_name" {
  description = "The domain name of the CIAM directory"
  value       = jsondecode(azapi_resource.ciam_directory.output).properties.domainName
}

output "default_domain" {
  description = "The default domain of the CIAM directory"
  value       = jsondecode(azapi_resource.ciam_directory.output).properties.defaultDomain
}

output "ciam_directory_id" {
  description = "The CIAM directory ID"
  value       = jsondecode(azapi_resource.ciam_directory.output).properties.ciamDirectoryId
  sensitive   = true
}

output "provisioning_state" {
  description = "The provisioning state of the CIAM directory"
  value       = jsondecode(azapi_resource.ciam_directory.output).properties.provisioningState
}

output "location" {
  description = "The location of the CIAM directory"
  value       = azapi_resource.ciam_directory.location
}

output "data_location" {
  description = "The data residency location of the CIAM directory"
  value       = var.data_location
}

output "sku_name" {
  description = "The SKU name of the CIAM directory"
  value       = var.sku_name
}

output "initial_admin_created" {
  description = "Whether an initial domain administrator was created"
  value       = var.initial_domain_administrator != null
  sensitive   = true
}

output "tags" {
  description = "The tags assigned to the CIAM directory"
  value       = var.tags
}