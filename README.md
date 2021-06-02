# Terragrunt Cloudtruth Deploy
Terragrunt [DRY deploy across environments](https://terragrunt.gruntwork.io/docs/getting-started/quick-start/#promote-immutable-versioned-terraform-modules-across-environments) with [CloudTruth run](https://docs.cloudtruth.com/configuration-management/cli-and-api/cloudtruth-cli#cloudtruth-run)

This repository contains Terragrunt HCL that will create an AWS Instance and S3 bucket deployed with Terragrunt utilizing CloudTruth to manage Terraform variable keys and values for a prod, stage and qa environment.

Rather than using terragrunt inputs to define environment parameter values we will inject inputs directlu from a CloudTruth project.

```
# terragrunt-cloudtruth-deploy
├── prod
│   ├── instance
│   │   └── terragrunt.hcl
│   ├── s3
│   │   └── terragrunt.hcl
│   └── terragrunt.hcl
│       
├── qa
│   ├── instance
│   │   └── terragrunt.hcl
│   ├── s3
│   │   └── terragrunt.hcl
│   └── terragrunt.hcl
│       
└── stage
    ├── instance
    │   └── terragrunt.hcl
    ├── s3
    │   └── terragrunt.hcl
    └── terragrunt.hcl
        
```

The ``instance`` and ``s3`` folders contain a ``terragrunt.hcl`` file that set the source parameter to point at the specific modules in the [``terragrunt-cloudtruth-modules``](https://github.com/cloudtruth-demo/terragrunt-cloudtruth-modules) repo.  They also ``include`` the top level ``terragrunt.hcl`` file in the  ``prod``, ``qa``, and ``stage`` folders.  

The top level ``terragrunt.hcl`` file specifies the aws provider configuration. 
