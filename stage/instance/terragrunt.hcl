# terrafrunt-cloudtruth-deploy/stage/instance/terragrunt.hcl
terraform {
  source = "git::https://github.com/cloudtruth-demo/terragrunt-cloudtruth-modules.git//instance?ref=v0.0.1"
}

include {
  path = find_in_parent_folders()
}
