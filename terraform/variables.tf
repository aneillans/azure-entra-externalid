variable "display_name" {
  description = "The display name of the CIAM directory"
  type        = string
}

variable "country_code" {
  description = "The country code for the CIAM directory (e.g., 'US', 'GB', 'DE')"
  type        = string
}

variable "location" {
  description = "The Azure region where the CIAM directory will be created (global,unitedstates,europe,asiapacific,australia,japan)"
  type        = string
}

variable "domain_name" {
  description = "The custom domain name for the CIAM directory (optional)"
  type        = string
  default     = null
}

variable "sku_name" {
  description = "The SKU name for the CIAM directory"
  type        = string
  default     = "Base"
  validation {
    condition = contains([
      "Base",
      "Standard", 
      "PremiumP1",
      "PremiumP2"
    ], var.sku_name)
    error_message = "The sku_name must be one of: 'Base', 'Standard', 'PremiumP1', or 'PremiumP2'."
  }
}

variable "resource_group_id" {
  description = "The full Azure resource ID of the resource group where the CIAM directory will be created"
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