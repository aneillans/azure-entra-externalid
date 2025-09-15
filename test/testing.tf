module "ciam_directory" {
  source = "../terraform"

  # Required variables
  display_name = "MyCompany External ID"
  country_code = "US"
  location     = "eastus"
  tenant_id    = "your-tenant-id-here" # Replace with your actual tenant ID

  # Optional variables with custom values
  data_location = "United States"
  sku_name      = "PremiumP1"
  domain_name   = "mycompany.onmicrosoft.com" # Optional custom domain

  # Domain and security settings
  domain_settings = {
    enable_certificate_based_authentication = false
    enable_password_policy_enforcement      = true
    password_policy = {
      minimum_length                = 12
      require_uppercase             = true
      require_lowercase             = true
      require_numbers               = true
      require_special_characters    = true
      password_history_count        = 24
      maximum_password_age_in_days  = 90
      minimum_password_age_in_hours = 24
    }
  }

  security_settings = {
    enable_risk_based_access_policies = false
    enable_conditional_access         = false
    enable_identity_protection        = false
    enable_mfa_enforcement            = false
  }

  # Branding settings
  branding_settings = {
    company_name       = "My Company"
    primary_color      = "#0078d4"
    background_color   = "#ffffff"
    privacy_policy_url = "https://mycompany.com/privacy"
    terms_of_use_url   = "https://mycompany.com/terms"
    support_url        = "https://support.mycompany.com"
  }

  # Tags
  tags = {
    Environment = "Development"
    Project     = "External Identity"
    Owner       = "IT Department"
  }

  # Optional: Create initial domain administrator
  # initial_domain_administrator = {
  #   user_principal_name = "admin@mycompany.onmicrosoft.com"
  #   display_name        = "External ID Administrator"
  #   password            = "SecurePassword123!" # Use a secure password
  # }
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