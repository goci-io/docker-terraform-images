# docker-terraform-aws

This [Dockerfile](https://github.com/goci-io/docker-terraform-images/tree/master/aws/Dockerfile) builds a version pinned environment to execute terraform on AWS and enables you to deploy a kops managed kubernetes cluster. 

Checkout [all terraform images](https://github.com/goci-io/docker-terraform-images)

### Binaries and Packages

- Terraform 0.12.6  
- AWS CLI   
- [tfenv](https://github.com/cloudposse/tfenv) 0.4.0  
- Kubectl 1.13.9  
- [Kops](https://github.com/kubernetes/kops) 1.13.0  
- [Helm](https://helm.sh/) 2.14.3  
- Predownload Terraform AWS provider ~> 2.24  
- Predownload Terraform Kubernetes provider ~> 1.8  
- unzip make git bash python3
- based on alpine 3.10

To prevent downloading newer versions for terraform providers, specify the version for the provider in terraform using the following variables:

- AWS provider version: `tf_provider_aws_version`  
- Kubernetes provider version: `tf_provider_k8s_version`  

### Configuration

In order to enable the container on AWS hosted environments to get credentials you need to pass the environment variables `AWS_CONTAINER_CREDENTIALS_RELATIVE_URI` and `AWS_DEFAULT_REGION` into the container. 

If you are not running on an AWS managed environment (eg: CodeBuild) you need to pass security credentials into the container and make sure the container has access to AWS. 

The permissions you grant to the CodeBuild role or user you create heavily depend on what you define in terraform. 
