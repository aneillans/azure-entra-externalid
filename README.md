# Azure Entra External ID Terraform Module

A Terraform module that creates and manages Azure Entra External ID (CIAM) directories using the Microsoft.AzureActiveDirectory/ciamDirectories resource type.

## Overview

This module provides a simple wrapper around the Azure API for creating Customer Identity and Access Management (CIAM) directories in Azure Entra External ID. It allows you to easily provision and configure external identity directories for your customer-facing applications.

## Features

- Creates Azure Entra External ID (CIAM) directories
- Configurable password policies and security settings
- Branding customization support
- Optional initial domain administrator creation
- Comprehensive tagging support
- Data residency configuration

## Usage

### Basic Example

```hcl
module "ciam_directory" {
  source = "./terraform"

  display_name = "MyCompany External ID"
  country_code = "US"
  location     = "eastus"
  tenant_id    = "your-tenant-id-here"

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

  display_name  = "MyCompany Customer Directory"
  country_code  = "US"
  location      = "eastus"
  data_location = "United States"
  tenant_id     = "your-tenant-id-here"
  sku_name      = "PremiumP2"

  domain_settings = {
    enable_password_policy_enforcement = true
    password_policy = {
      minimum_length                   = 12
      require_uppercase               = true
      require_lowercase               = true
      require_numbers                 = true
      require_special_characters      = true
      password_history_count          = 24
      maximum_password_age_in_days    = 90
    }
  }

  security_settings = {
    enable_conditional_access  = true
    enable_mfa_enforcement    = true
  }

  branding_settings = {
    company_name       = "My Company"
    primary_color      = "#0078d4"
    background_color   = "#ffffff"
    privacy_policy_url = "https://mycompany.com/privacy"
    terms_of_use_url   = "https://mycompany.com/terms"
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
| azurerm | ~> 4.0 |
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
| location | The Azure region where the CIAM directory will be created | `string` | n/a | yes |
| tenant_id | The tenant ID where the CIAM directory will be created | `string` | n/a | yes |
| data_location | The data residency location | `string` | `"United States"` | no |
| domain_name | The custom domain name for the CIAM directory | `string` | `null` | no |
| sku_name | The SKU name for the CIAM directory | `string` | `"PremiumP1"` | no |
| tags | A map of tags to assign to the CIAM directory | `map(string)` | `{}` | no |
| domain_settings | Domain configuration settings | `object` | `{}` | no |
| security_settings | Security configuration for the CIAM directory | `object` | `{}` | no |
| branding_settings | Branding configuration for the CIAM directory | `object` | `{}` | no |
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
| data_location | The data residency location of the CIAM directory |
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
2. Update the `testing.tf` file with your specific values (tenant ID, subscription ID, etc.)
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
- Data location affects where user data is stored and cannot be changed after creation
- Some features require Premium P2 SKU

## Support

For issues related to the Azure Entra External ID service itself, please refer to the [Azure documentation](https://docs.microsoft.com/en-us/azure/active-directory-b2c/).