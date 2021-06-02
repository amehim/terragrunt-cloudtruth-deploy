# Terragrunt CloudTruth Deploy
Terragrunt [DRY deploy tutorial across multiple environments](https://terragrunt.gruntwork.io/docs/getting-started/quick-start/#promote-immutable-versioned-terraform-modules-across-environments) with [CloudTruth run](https://docs.cloudtruth.com/configuration-management/cli-and-api/cloudtruth-cli#cloudtruth-run)

This repository contains Terragrunt HCL that will create an AWS Instance in us-west-2 and an S3 bucket deployed with Terragrunt utilizing CloudTruth to manage Terraform variable keys and values for a devlopment, production, and staging environment.

Rather than using hardcoded and scattered Terragrunt [inputs](https://terragrunt.gruntwork.io/docs/features/inputs/) to define environment parameter values, we will inject inputs directly from a CloudTruth project.

Terragrunt folder structure
```
# terragrunt-cloudtruth-deploy
├── development
│   ├── instance
│   │   └── terragrunt.hcl
│   ├── s3
│   │   └── terragrunt.hcl
│   └── terragrunt.hcl
│       
├── production
│   ├── instance
│   │   └── terragrunt.hcl
│   ├── s3
│   │   └── terragrunt.hcl
│   └── terragrunt.hcl
│       
└── staging
    ├── instance
    │   └── terragrunt.hcl
    ├── s3
    │   └── terragrunt.hcl
    └── terragrunt.hcl
        
```

The ``instance`` and ``s3`` sub-folders contain a ``terragrunt.hcl`` file that set the source parameter to point at the specific modules in the [``terragrunt-cloudtruth-modules``](https://github.com/cloudtruth-demo/terragrunt-cloudtruth-modules) repo.  They also ``include`` the top level ``terragrunt.hcl`` file in the  ``development``, ``production``, and ``staging`` folders.  

The top level ``terragrunt.hcl`` file for each environment specifies the aws provider configuration. 

## Setup
1. Clone this repo ``terragrunt-cloudtruth-deploy``
2. Create a CloudTruth Project with the [CloudTruth CLI](https://docs.cloudtruth.com/configuration-management/cli-and-api/cloudtruth-cli#installation)

    **Create a CloudTruth Project**
    ```
    cloudtruth project set Terragrunt
    ```

    **Setup CloudTruth Parameters required by the [Terraform Modules](https://github.com/cloudtruth-demo/terragrunt-cloudtruth-modules/blob/main/instance/variables.tf)**
    ```
    cloudtruth --project Terragrunt parameter set TF_VAR_ami -v ami-830c94e3 --secret true
    cloudtruth --project Terragrunt parameter set TF_VAR_instance_type -v t2.micro
    cloudtruth --project Terragrunt parameter set TF_VAR_availability_zone_names -v \[\"us-west-2a\",\ \"us-west-2b\"\]
    cloudtruth --project Terragrunt parameter set TF_VAR_resource_tags -v \{\"Name\":\"Cloudtruth-Instance\",\"project\":\"CloudTruth\ Run\ Terraform\",\"environment\":\"default\"\}
    ```

    **Create CloudTruth Environments**
    ```
    cloudtruth environment set development
    cloudtruth environment set production
    cloudtruth environment set staging
    ```

    **Override variable TF_VAR_resource_tags in each environment**
    ```
    cloudtruth --project Terragrunt --env development parameter set TF_VAR_resource_tags -v \{\"Name\":\"CloudTruth-development\",\"project\":\"CloudTruth\ Run\ Terraform\",\"environment\":\"development\"\}
    cloudtruth --project Terragrunt --env production parameter set TF_VAR_resource_tags -v \{\"Name\":\"CloudTruth-production\",\"project\":\"CloudTruth\ Run\ Terraform\",\"environment\":\"production\\"\}
    cloudtruth --project Terragrunt --env staging parameter set TF_VAR_resource_tags -v \{\"Name\":\"CloudTruth-staging\",\"project\":\"CloudTruth\ Run\ Terraform\",\"environment\":\"staging\\"\}
    ```

## Running
Terragrunt will respect any ``TF_VAR_xxx`` variables you’ve manually set in your environment.  Using ``CloudTruth Run`` we will pass the configured ``TF_VAR_xxx`` variables  directly to the Terraform modules with Terragrunt.  This allows you keep your configuration DRY and have a centrally managed source of truth for your configuration management.


