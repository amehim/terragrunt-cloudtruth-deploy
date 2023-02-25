# terragrunt-cloudtruth-deploy/staging/terragrunt.hcl
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

inputs = {
  # tfvars for staging
  instance_count = 1
  instance_type  = "t2.micro"
  ami = "ami-0557a15b87f6559cf"
  availability_zone_names = ["us-east-1a","us-east-1b","us-east-1c"]
  resource_tags = "test-vm"
}
