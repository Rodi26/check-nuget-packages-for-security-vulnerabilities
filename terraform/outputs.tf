# GitHub Secrets Outputs
output "github_secrets_created" {
  description = "GitHub secrets that were created"
  value = [
    github_actions_secret.jfrog_url.secret_name,
    github_actions_secret.jfrog_instance_id.secret_name
  ]
}

# JFrog Configuration Outputs
output "jfrog_virtual_repository" {
  description = "Details of the existing virtual NuGet repository"
  value = {
    name = var.virtual_repo_name
    url  = "${var.jfrog_url}/artifactory/${var.virtual_repo_name}"
  }
}

output "oidc_provider_configured" {
  description = "OIDC provider configuration details"
  value = {
    name     = var.oidc_provider_name
    audience = var.oidc_audience
    issuer   = "https://token.actions.githubusercontent.com"
    identity_mapping = var.oidc_identity_mapping
  }
}

output "next_steps" {
  description = "Next steps to complete the setup"
  value = <<-EOT
    Setup completed successfully!
    
    Next steps:
    1. Verify GitHub secrets are set in your repository settings
    2. Test the GitHub Actions workflow
    3. Verify OIDC authentication works in JFrog Artifactory
    
    GitHub Secrets created:
    - JFROG_URL: ${var.jfrog_url}
    - JFROG_INSTANCE_ID: ${var.jfrog_instance_id}
    
    Virtual Repository URL:
    ${var.jfrog_url}/artifactory/${var.virtual_repo_name}
    
    OIDC Provider: ${var.oidc_provider_name}
    OIDC Audience: ${var.oidc_audience}
  EOT
} 