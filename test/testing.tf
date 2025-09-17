module "ciam_directory" {
  source = "../terraform"

  resource_group_id = "/subscriptions/b568099c-fb2f-4e51-946f-d9e40f80e73b/resourceGroups/testing"

  # Required variables
  display_name = "MyCompany External ID"
  country_code = "US"
  location     = "unitedstates"

  sku_name      = "Base"
  domain_name   = "blahblahtest.onmicrosoft.com"

  # Tags
  tags = {
    Environment = "Development"
    Project     = "External Identity"
    Owner       = "IT Department"
  }
}

# Output important values
output "ciam_directory_id" {
  value       = module.ciam_directory.id
  description = "The resource ID of the created CIAM directory"
}

output "domain_name" {
  value       = module.ciam_directory.domain_name
  description = "The domain name of the CIAM directory"
}

output "tenant_id" {
  value       = module.ciam_directory.tenant_id
  description = "The tenant ID of the CIAM directory"
  sensitive   = true
}

output "provisioning_state" {
  value       = module.ciam_directory.provisioning_state
  description = "The provisioning state of the CIAM directory"
}