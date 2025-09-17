# Azure Entra External ID Terraform Module

A simplified Terraform module that creates and manages Azure Entra External ID (CIAM) directories using the Microsoft.AzureActiveDirectory/ciamDirectories resource type.

## Overview

This module provides a simple wrapper around the Azure API for creating basic Customer Identity and Access Management (CIAM) directories in Azure Entra External ID. It focuses on the essential configuration needed to provision external identity directories for your customer-facing applications.

## Features

- Creates Azure Entra External ID (CIAM) directories
- Basic tenant configuration with country code and display name
- SKU selection (Standard, PremiumP1, PremiumP2)
- Optional custom domain configuration
- Optional initial domain administrator creation
- Comprehensive tagging support

## Usage

### Basic Example

```hcl
module "ciam_directory" {
  source = "./terraform"

  display_name      = "MyCompany External ID"
  country_code      = "US"
  location          = "unitedstates"
  resource_group_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/your-resource-group-name"

  tags = {
    Environment = "Production"
    Project     = "Customer Portal"
  }
}
```

### Advanced Example with Custom Configuration

```hcl
module "ciam_directory" {
  source = "./terraform"

  display_name      = "MyCompany Customer Directory"
  country_code      = "US"
  location          = "unitedstates"
  resource_group_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/your-resource-group-name"
  sku_name          = "PremiumP2"
  domain_name       = "mycustomdomain.onmicrosoft.com"

  # Optional: Create initial domain administrator
  initial_domain_administrator = {
    user_principal_name = "admin@mycustomdomain.onmicrosoft.com"
    display_name        = "External ID Administrator"
    password            = "SecurePassword123!" # Use a secure password
  }

  tags = {
    Environment = "Production"
    Project     = "Customer Identity"
    Owner       = "IT Department"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| azapi | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| azapi | ~> 2.0 |

## Resources

| Name | Type |
|------|------|
| azapi_resource.ciam_directory | resource |
| azapi_resource.initial_domain_admin | resource |
| azapi_resource.ciam_directory_data | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| display_name | The display name of the CIAM directory | `string` | n/a | yes |
| country_code | The country code for the CIAM directory (e.g., 'US', 'GB', 'DE') | `string` | n/a | yes |
| location | The Azure region where the CIAM directory will be created (global,unitedstates,europe,asiapacific,australia,japan) | `string` | n/a | yes |
| resource_group_id | The full Azure resource ID of the resource group where the CIAM directory will be created | `string` | n/a | yes |
| domain_name | The custom domain name for the CIAM directory | `string` | `null` | no |
| sku_name | The SKU name for the CIAM directory | `string` | `"PremiumP1"` | no |
| tags | A map of tags to assign to the CIAM directory | `map(string)` | `{}` | no |
| initial_domain_administrator | Configuration for the initial domain administrator | `object` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The resource ID of the CIAM directory |
| name | The name of the CIAM directory |
| tenant_id | The tenant ID of the CIAM directory |
| domain_name | The domain name of the CIAM directory |
| default_domain | The default domain of the CIAM directory |
| ciam_directory_id | The CIAM directory ID |
| provisioning_state | The provisioning state of the CIAM directory |
| location | The location of the CIAM directory |
| sku_name | The SKU name of the CIAM directory |
| initial_admin_created | Whether an initial domain administrator was created |
| tags | The tags assigned to the CIAM directory |

## Authentication

This module requires appropriate Azure credentials with permissions to create and manage Azure Entra External ID resources. Ensure your service principal or user account has the necessary permissions:

- `External ID User Flow Administrator`
- `External ID User Flow Attribute Administrator` 
- `Application Administrator` (for branding configurations)

## Testing

To test the module:

1. Navigate to the `test/` directory
2. Update the `testing.tf` file with your specific values (resource group ID, etc.)
3. Run the following commands:

```bash
cd test/
terraform init
terraform plan
terraform apply
```

## Notes

- CIAM directories are region-specific resources
- SKU changes may require directory recreation
- Supported SKU values: `Standard`, `PremiumP1`, `PremiumP2`
- Custom domains can be specified but may require additional DNS configuration
- The module creates a basic CIAM directory without advanced policy configurations

## Support

For issues related to the Azure Entra External ID service itself, please refer to the [Azure documentation](https://docs.microsoft.com/en-us/azure/active-directory-b2c/).