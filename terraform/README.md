# Terraform Configuration for GitHub Secrets and JFrog OIDC

This Terraform configuration sets up GitHub repository secrets and JFrog Artifactory OIDC authentication for secure package management.

## Prerequisites

1. **Terraform** (version >= 1.0)
2. **Environment Variables** set in your SSH session:
   - `GITHUB_TOKEN`: GitHub personal access token with `repo` and `admin:org` permissions
   - `JFROG_TOKEN`: JFrog Artifactory admin token with administrative privileges

**Note**: The providers will automatically read these environment variables.

## Configuration

### 1. Copy the example variables file

```bash
cp terraform.tfvars.example terraform.tfvars
```

### 2. Set Environment Variables

Set the required environment variables in your SSH session:

```bash
export GITHUB_TOKEN="ghp_your_actual_github_token"
export JFROG_TOKEN="your_actual_jfrog_admin_token"
```

The providers will automatically detect and use these environment variables.

### 3. Create terraform.tfvars

Create a `terraform.tfvars` file with the following variables:

```hcl
# GitHub Configuration
github_owner     = "your-github-username-or-org"
github_repository = "check-nuget-packages-for-security-vulnerabilities"

# JFrog Artifactory Configuration
jfrog_url        = "https://your-instance.jfrog.io"
jfrog_instance_id = "your-instance-id"
```

### 4. Initialize Terraform

```bash
terraform init
```

### 5. Plan the deployment

```bash
terraform plan
```

### 6. Apply the configuration

```bash
terraform apply
```

## What This Creates

### GitHub Repository Secrets
- `JFROG_URL`: Your JFrog Artifactory URL
- `JFROG_INSTANCE_ID`: Your JFrog instance ID

### JFrog OIDC Configuration
- OIDC provider and identity mapping for GitHub Actions authentication

## Provider Versions

The configuration uses the following provider versions:

- **GitHub**: `~> 6.0`
- **JFrog Platform**: `2.2.5`

### JFrog Artifactory Configuration
- **OIDC Provider**: `rodolphef-nuget-webui`
  - Configured for GitHub Actions OIDC
  - Audience: `rodolphef-lollms-nuget-audience`
  - Issuer: `https://token.actions.githubusercontent.com`

- **Virtual NuGet Repository**: Uses existing `soleng-dev-nuget` repository
  - Assumes the repository already exists in JFrog Artifactory
  - Configures OIDC authentication for the existing repository

## Security Features

1. **OIDC Authentication**: Uses GitHub Actions OIDC tokens instead of long-lived credentials
2. **Secure Token Management**: No passwords stored in GitHub secrets
3. **Repository Isolation**: Virtual repository with controlled access
4. **Audit Trail**: All package operations are logged and traceable

## Verification

After applying the Terraform configuration:

1. **Check GitHub Secrets**: Go to your repository settings → Secrets and variables → Actions
2. **Verify JFrog OIDC**: Check the OIDC provider configuration in JFrog Artifactory
3. **Test Virtual Repository**: Try accessing the virtual repository URL
4. **Run GitHub Actions**: Trigger a workflow to test the complete setup

## Troubleshooting

### Common Issues

1. **Permission Denied**: Ensure your GitHub token has the required permissions
2. **JFrog Authentication**: Verify your JFrog admin token is valid
3. **OIDC Configuration**: Check that the OIDC provider is properly configured in JFrog

### Useful Commands

```bash
# Check Terraform state
terraform show

# Destroy the configuration (if needed)
terraform destroy

# Validate the configuration
terraform validate
```

## Cleanup

To remove all created resources:

```bash
terraform destroy
```

**Warning**: This will remove all GitHub secrets and JFrog configurations created by this Terraform configuration.

## Support

For issues related to:
- **Terraform**: Check the Terraform documentation
- **GitHub Actions**: Refer to GitHub Actions documentation
- **JFrog Artifactory**: Consult JFrog documentation 