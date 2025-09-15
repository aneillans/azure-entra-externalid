variable "display_name" {
  description = "The display name of the CIAM directory"
  type        = string
}

variable "country_code" {
  description = "The country code for the CIAM directory (e.g., 'US', 'GB', 'DE')"
  type        = string
}

variable "location" {
  description = "The Azure region where the CIAM directory will be created"
  type        = string
}

variable "data_location" {
  description = "The data residency location (e.g., 'United States', 'Europe', 'Asia Pacific')"
  type        = string
  default     = "United States"
}

variable "domain_name" {
  description = "The custom domain name for the CIAM directory (optional)"
  type        = string
  default     = null
}

variable "sku_name" {
  description = "The SKU name for the CIAM directory"
  type        = string
  default     = "PremiumP1"
  validation {
    condition = contains([
      "PremiumP1",
      "PremiumP2"
    ], var.sku_name)
    error_message = "The sku_name must be either 'PremiumP1' or 'PremiumP2'."
  }
}

variable "tenant_id" {
  description = "The tenant ID where the CIAM directory will be created"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the CIAM directory"
  type        = map(string)
  default     = {}
}

variable "initial_domain_administrator" {
  description = "Configuration for the initial domain administrator"
  type = object({
    user_principal_name = string
    display_name        = string
    password            = string
  })
  sensitive = true
  default   = null
}

variable "domain_settings" {
  description = "Domain configuration settings"
  type = object({
    enable_certificate_based_authentication = optional(bool, false)
    enable_password_policy_enforcement      = optional(bool, true)
    password_policy = optional(object({
      minimum_length                = optional(number, 8)
      require_uppercase             = optional(bool, true)
      require_lowercase             = optional(bool, true)
      require_numbers               = optional(bool, true)
      require_special_characters    = optional(bool, true)
      password_history_count        = optional(number, 24)
      maximum_password_age_in_days  = optional(number, 90)
      minimum_password_age_in_hours = optional(number, 24)
    }), {})
  })
  default = {}
}

variable "security_settings" {
  description = "Security configuration for the CIAM directory"
  type = object({
    enable_risk_based_access_policies = optional(bool, false)
    enable_conditional_access         = optional(bool, false)
    enable_identity_protection        = optional(bool, false)
    enable_mfa_enforcement            = optional(bool, false)
  })
  default = {}
}

variable "branding_settings" {
  description = "Branding configuration for the CIAM directory"
  type = object({
    company_name       = optional(string)
    primary_color      = optional(string)
    background_color   = optional(string)
    logo_url           = optional(string)
    favicon_url        = optional(string)
    privacy_policy_url = optional(string)
    terms_of_use_url   = optional(string)
    support_url        = optional(string)
  })
  default = {}
}