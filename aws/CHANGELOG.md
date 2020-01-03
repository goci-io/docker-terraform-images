# Changelog AWS

Each release corresponds to a docker tag. The docker tag convention is `<version>-aws`

## v1.6

### Updates
- `TF_FLAT_MODULE` to allow running action on the `/data` directory only  
- add stable helm repo and update the helm repo on build  

## [v1.5](https://github.com/goci-io/docker-terraform-images/releases/tag/v1.5-aws)

### Updates
- `kubectl` updated to 1.15.7  
- `kops` updated to 1.15.0  
- `kubernetes` version set to 1.15.7  
- `terraform` updated to 0.12.18  
- `helm` updated to 3.0.2 (finally without tiller)  

### Fixes
none

### Migration
Note the update of apiGroup when updating the [kops cluster](https://github.com/goci-io/aws-kops-cluster/commit/55b44c527303b78920690c116ca9da764d1ba2a8) with terraform.

## [v1.4](https://github.com/goci-io/docker-terraform-images/releases/tag/v1.4-aws)

### Updates
- `kubectl` updated to 1.15.5
- `kops` updated to 1.14.0
- `kubernetes` version set to 1.14.8
- `terraform` updated to 0.12.13
- `helm` updated to 2.15.5
- above versions are defined as environment variables and can also be accessed using terraform variables (eg. `var.kubernetes_version` or `var.terraform_version`)
- clarified documentation on shared environment variables
- added `CLUSTER_TLD` for kops cluster name (defaults to `io`)

Related kubernetes version update on [goci-io/aws-kops-cluster](https://github.com/goci-io/aws-kops-cluster/commit/d5ce155a0323d10d0f4ec0e4af15d1d56a484acc). Sourced from `KUBERNETES_VERSION`

### Fixes
- added `s3://` prefix to `KOPS_STATE_STORE` 

**You will need to do a rolling update on your existing clusters.**

## [v1.3](https://github.com/goci-io/docker-terraform-images/releases/tag/v1.3-aws)

### Updates
- set KOPS_ env vars when `KOPS_CLUSTER_NAME` is not set  
- add curl utility  
- add aws-vault to get AWS session locally  
- optionally set TF_ backend env vars when `TF_BUCKET` is not set  
- add dynamodb table for locking to init command  
- remove some verbose/duplicate output  
- add cloudposse alpine repository  

### Fixes
none 

## [v1.2](https://github.com/goci-io/docker-terraform-images/releases/tag/v1.2-aws)

### Updates
- `kubectl` to version 1.13.10  
- `terraform` to version 0.12.8  
- switch only once into module directory  

### Fixes
- remove `-no-color` from `TF_CLI_ARGS` and add it to apply, plan, init and destroy  (https://github.com/hashicorp/terraform/issues/14847)

## [v1.1](https://github.com/goci-io/docker-terraform-images/releases/tag/v1.1-aws)

### Updates
- Upgrade to Terraform 0.12.7 
- Added jq, tar and keybase-client@testing packages
- Use plan file to apply terraform (show diff before)
- Provide `AWS_ASSUME_ROLE_ARN` if needed (eg: for terraform)

### Fixes
none
