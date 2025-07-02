terraform {
  required_version = ">= 1.0"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    platform = {
      source  = "jfrog/platform"
      version = "2.2.5"
    }
  }
}

# GitHub Provider Configuration
provider "github" {}

# JFrog Platform Provider Configuration
provider "platform" {
  url = var.jfrog_url
  // supply JFROG_TOKEN as env var
}

# GitHub Repository Secrets
resource "github_actions_secret" "jfrog_url" {
  repository      = var.github_repository
  secret_name     = "JFROG_URL"
  plaintext_value = var.jfrog_url
}

resource "github_actions_secret" "jfrog_instance_id" {
  repository      = var.github_repository
  secret_name     = "JFROG_INSTANCE_ID"
  plaintext_value = var.jfrog_instance_id
}

# JFrog OIDC Provider Configuration
resource "platform_oidc_configuration" "github_actions_oidc" {
  name          = var.oidc_provider_name
  description   = var.oidc_provider_name
  issuer_url    = "https://token.actions.githubusercontent.com"
  provider_type = "GitHub"
  audience      = var.oidc_audience
  organization  = var.github_owner
}

# JFrog OIDC Identity Mapping
resource "platform_oidc_identity_mapping" "github_actions_identity_mapping" {
  name          = var.oidc_identity_mapping
  description   = "GitHub Actions OIDC user identity mapping"
  provider_name = var.oidc_provider_name
  priority      = 1

  claims_json = jsonencode({
    "actor"      = var.github_owner
    "repository" = "${var.github_owner}/${var.github_repository}"
  })

  token_spec = {
    username   = "${var.github_owner}@jfrog.com"
    scope      = "applied-permissions/user"
    audience   = "*@*"
    expires_in = 7200
  }
}

 