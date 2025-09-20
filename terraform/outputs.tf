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
  value       = azapi_resource.ciam_directory.output.properties.tenantId
  sensitive   = true
}

output "domain_name" {
  description = "The domain name of the CIAM directory"
  value       = azapi_resource.ciam_directory.output.properties.domainName
}

output "provisioning_state" {
  description = "The provisioning state of the CIAM directory"
  value       = azapi_resource.ciam_directory.output.properties.provisioningState
}

output "location" {
  description = "The location of the CIAM directory"
  value       = azapi_resource.ciam_directory.location
}

output "sku_name" {
  description = "The SKU name of the CIAM directory"
  value       = var.sku_name
}

output "initial_admin_created" {
  description = "Whether an initial domain administrator was created"
  value       = var.initial_domain_administrator != null
}

output "tags" {
  description = "The tags assigned to the CIAM directory"
  value       = var.tags
}