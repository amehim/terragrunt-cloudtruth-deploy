# terrafrunt-cloudtruth-deploy/prod/s3/terragrunt.hcl
terraform {
  source = "git::https://github.com/cloudtruth-demo/terragrunt-cloudtruth-modules.git//s3?ref=v0.0.1"
}

include {
  path = find_in_parent_folders()
}
