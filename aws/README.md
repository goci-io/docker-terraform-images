# docker-terraform-aws

This [Dockerfile](Dockerfile) builds a version pinned terraform environment. 

### Binaries

- Terraform 0.12.6  
- AWS CLI   
- Kubectl 1.13.9  
- Predownload Terraform AWS provider ~> 2.24  
- Predownload Terraform Kubernetes provider ~> 1.8  
- unzip make git bash python3
- based from alpine 3.10

### Configuration

In order to enable the container on AWS hosted environments to get credentials you need to pass the environment variables `AWS_CONTAINER_CREDENTIALS_RELATIVE_URI` and `AWS_DEFAULT_REGION` into the container.