resource "azapi_resource" "ciam_directory" {
  type                      = "Microsoft.AzureActiveDirectory/ciamDirectories@2023-05-17-preview"
  schema_validation_enabled = false
  location                  = var.location
  parent_id                 = var.resource_group_id
  ignore_casing             = true
  name                      = var.domain_name

  body = {
    properties = {
      createTenantProperties = {
        countryCode  = var.country_code
        displayName = var.display_name
      }

      billingConfig = {
        billingType = "MAU"
      }

   }

    sku = {
      name = var.sku_name
      tier = "A0"
    }

  }



  tags = var.tags
  

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

  response_export_values = [
    "properties.tenantId",
    "properties.domainName",
    "properties.provisioningState"
  ]
}

# # Optional: Create initial domain administrator if specified
# resource "azapi_resource" "initial_domain_admin" {
#   count = var.initial_domain_administrator != null ? 1 : 0

#   type                      = "Microsoft.Graph/users@v1.0"
#   schema_validation_enabled = false
#   name                      = var.initial_domain_administrator.user_principal_name
#   parent_id                 = azapi_resource.ciam_directory.id
#   ignore_casing             = true

#   body = {
#     userPrincipalName = var.initial_domain_administrator.user_principal_name
#     displayName       = var.initial_domain_administrator.display_name
#     passwordProfile = {
#       password                      = var.initial_domain_administrator.password
#       forceChangePasswordNextSignIn = true
#     }
#     accountEnabled = true
#   }

#   depends_on = [azapi_resource.ciam_directory]
# }

# # Data source to read back the created CIAM directory
# data "azapi_resource" "ciam_directory_data" {
#   type                   = "Microsoft.AzureActiveDirectory/ciamDirectories@2023-01-18-preview"
#   resource_id            = azapi_resource.ciam_directory.id
#   response_export_values = ["*"]
#   depends_on             = [azapi_resource.ciam_directory]
# }