# docker-terraform-aws

This [Dockerfile](/aws/Dockerfile) builds a version pinned terraform environment with AWS CLI and Terraform AWS provider predownloaded. 

Checkout [all terraform images](https://github.com/goci-io/docker-terraform-images)

### Binaries

- Terraform 0.12.6  
- AWS CLI   
- [tfenv](https://github.com/cloudposse/tfenv) 0.4.0  
- Kubectl 1.13.9  
- Predownload Terraform AWS provider ~> 2.24  
- Predownload Terraform Kubernetes provider ~> 1.8  
- unzip make git bash python3
- based on alpine 3.10

### Configuration

In order to enable the container on AWS hosted environments to get credentials you need to pass the environment variables `AWS_CONTAINER_CREDENTIALS_RELATIVE_URI` and `AWS_DEFAULT_REGION` into the container. 

If you are not running on an AWS managed environment (eg: CodeBuild) you need to pass security credentials into the container and make sure the container has access to AWS. 

The permissions you grant to the CodeBuild role or user you created heavily depend on what are you executing within terraform. 
