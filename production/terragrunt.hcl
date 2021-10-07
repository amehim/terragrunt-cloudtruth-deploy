# terragrunt-cloudtruth-deploy/production/terragrunt.hcl
generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  profile = "default"
  region  = "us-west-2"
}
EOF
}