# GitHub Configuration Variables
# GitHub token will be read from GITHUB_TOKEN environment variable

variable "github_owner" {
  description = "GitHub organization or username (used for OIDC configuration)"
  type        = string
}

variable "github_repository" {
  description = "GitHub repository name"
  type        = string
}

variable "github_oidc_client_id" {
  description = "GitHub OIDC client ID (usually the repository name)"
  type        = string
  default     = "check-nuget-packages-for-security-vulnerabilities"
}

# JFrog Artifactory Configuration Variables
variable "jfrog_url" {
  description = "JFrog Artifactory URL"
  type        = string
}

# JFrog token will be read from JFROG_TOKEN environment variable

variable "jfrog_instance_id" {
  description = "JFrog instance ID (part before .jfrog.io)"
  type        = string
}

# Optional Configuration Variables
variable "project_key" {
  description = "JFrog project key"
  type        = string
  default     = "sai"
}

variable "virtual_repo_name" {
  description = "Name of the virtual NuGet repository"
  type        = string
  default     = "soleng-dev-nuget"
}

variable "oidc_provider_name" {
  description = "Name of the OIDC provider"
  type        = string
  default     = "rodolphef-nuget-webui"
}

variable "oidc_audience" {
  description = "OIDC audience"
  type        = string
  default     = "rodolphef-lollms-nuget-audience"
}

variable "oidc_identity_mapping" {
  description = "Name of the OIDC identity mapping"
  type        = string
  default     = "github-actions-identity-mapping"
}

 