locals {
  default_domain_name = var.domain_name != null ? var.domain_name : "${replace(lower(var.display_name), " ", "")}.onmicrosoft.com"
}

resource "azapi_resource" "ciam_directory" {
  type                      = "Microsoft.AzureActiveDirectory/ciamDirectories@2023-01-18-preview"
  schema_validation_enabled = false
  location                  = var.location
  name                      = var.display_name
  parent_id                 = "/tenants/${var.tenant_id}"
  ignore_casing             = true

  body = {
    properties = {
      displayName  = var.display_name
      countryCode  = var.country_code
      dataLocation = var.data_location
      domainName   = local.default_domain_name

      skuProperties = {
        name = var.sku_name
      }

      directoryConfiguration = {
        passwordPolicy = var.domain_settings.password_policy != null ? {
          minimumLength             = var.domain_settings.password_policy.minimum_length
          requireUppercase          = var.domain_settings.password_policy.require_uppercase
          requireLowercase          = var.domain_settings.password_policy.require_lowercase
          requireNumbers            = var.domain_settings.password_policy.require_numbers
          requireSpecialCharacters  = var.domain_settings.password_policy.require_special_characters
          passwordHistoryCount      = var.domain_settings.password_policy.password_history_count
          maximumPasswordAgeInDays  = var.domain_settings.password_policy.maximum_password_age_in_days
          minimumPasswordAgeInHours = var.domain_settings.password_policy.minimum_password_age_in_hours
        } : null

        securitySettings = {
          enableCertificateBasedAuthentication = var.domain_settings.enable_certificate_based_authentication
          enablePasswordPolicyEnforcement      = var.domain_settings.enable_password_policy_enforcement
          enableRiskBasedAccessPolicies        = var.security_settings.enable_risk_based_access_policies
          enableConditionalAccess              = var.security_settings.enable_conditional_access
          enableIdentityProtection             = var.security_settings.enable_identity_protection
          enableMfaEnforcement                 = var.security_settings.enable_mfa_enforcement
        }
      }

      brandingConfiguration = var.branding_settings.company_name != null ? {
        companyName      = var.branding_settings.company_name
        primaryColor     = var.branding_settings.primary_color
        backgroundColor  = var.branding_settings.background_color
        logoUrl          = var.branding_settings.logo_url
        faviconUrl       = var.branding_settings.favicon_url
        privacyPolicyUrl = var.branding_settings.privacy_policy_url
        termsOfUseUrl    = var.branding_settings.terms_of_use_url
        supportUrl       = var.branding_settings.support_url
      } : null
    }

    tags = var.tags
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

  response_export_values = [
    "properties.tenantId",
    "properties.domainName",
    "properties.defaultDomain",
    "properties.provisioningState",
    "properties.ciamDirectoryId"
  ]
}

# Optional: Create initial domain administrator if specified
resource "azapi_resource" "initial_domain_admin" {
  count = var.initial_domain_administrator != null ? 1 : 0

  type                      = "Microsoft.Graph/users@v1.0"
  schema_validation_enabled = false
  name                      = var.initial_domain_administrator.user_principal_name
  parent_id                 = azapi_resource.ciam_directory.id
  ignore_casing             = true

  body = {
    userPrincipalName = var.initial_domain_administrator.user_principal_name
    displayName       = var.initial_domain_administrator.display_name
    passwordProfile = {
      password                      = var.initial_domain_administrator.password
      forceChangePasswordNextSignIn = true
    }
    accountEnabled = true
  }

  depends_on = [azapi_resource.ciam_directory]
}

# Data source to read back the created CIAM directory
data "azapi_resource" "ciam_directory_data" {
  type                   = "Microsoft.AzureActiveDirectory/ciamDirectories@2023-01-18-preview"
  resource_id            = azapi_resource.ciam_directory.id
  response_export_values = ["*"]
  depends_on             = [azapi_resource.ciam_directory]
}