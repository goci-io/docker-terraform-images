# docker-terraform-aws

This [Dockerfile](https://github.com/goci-io/docker-terraform-images/tree/master/aws/Dockerfile) builds a version pinned environment to execute terraform on AWS and enables you to deploy a kops managed kubernetes cluster. 

Checkout [all terraform images](https://github.com/goci-io/docker-terraform-images#overview)

Read about [general usage guidelines](https://github.com/goci-io/docker-terraform-images#usage)

```
docker run \
    -e NAMESPACE \
    -e STAGE \
    -e REGION \
    -e AWS_REGION \
    -e AWS_DEFAULT_REGION \
    -e AWS_CONTAINER_CREDENTIALS_RELATIVE_URI \
    -v <path_to_modules_dir>:/data \
    -i gocidocker/terraform-k8s-aws:v1.4 \
    [apply|plan|destroy]
```

To run this container locally (eg: for debug purposes) you can execute the following:

```
docker run --entrypoint=/conf/local-start.sh \
    -e NAMESPACE \
    -e STAGE \
    -e REGION \
    -e AWS_REGION=eu-central-1 \
    -v ${HOME}/.aws:/root/.aws:ro \
    -v ${HOME}/.awsvault:/root/.awsvault \
    -v <path_to_modules_dir>:/data \
    -it gocidocker/terraform-k8s-aws:v1.4 \
```

Running this container locally it will install [aws-vault](https://github.com/99designs/aws-vault) and asks you to unlock your aws-vault keys. This behaviour is enabled until `AWS_VAULT_ENABLED` is set to `false`. You will need to mount the `.aws` and `.awsvault` directory into the container.

### Binaries and Packages

- Terraform 0.12.13  
- AWS CLI   
- [tfenv](https://github.com/cloudposse/tfenv) 0.4.0  
- [Kubectl](https://github.com/kubernetes/kubectl) 1.15.5  
- [Kops](https://github.com/kubernetes/kops) 1.14.0  
- [Helm](https://helm.sh/) 2.15.2  
- based on alpine 3.10

Utilities: unzip, tar, make, git, curl, bash, jq, python3, keybase-client@testing

### Configuration

In order to enable the container on AWS hosted environments to get credentials you need to pass the environment variables `AWS_CONTAINER_CREDENTIALS_RELATIVE_URI` and `AWS_DEFAULT_REGION` into the container. 

If you are not running on an AWS managed environment (eg: CodeBuild) you need to pass security credentials into the container and make sure the container has access to AWS. The permissions you grant to the CodeBuild role or user you create heavily depend on what you define in terraform. 

We assume when hosted on AWS that S3 is used as state backend for Terraform. You can find a module to provision the backend [here](https://github.com/goci-io/tfstate-backend-aws).

Please note the following additional environment variables provided by the docker-entrypoint for AWS specifically:

| Name | Default and description | 
|-----------------|-----------------------------------------------------------------------|
| AWS_ASSUME_ROLE_ARN | Created from `AWS_ACCOUNT_ID` if `AWS_ASSUME_ROLE_NAME` is set to a role name |

Read about [environment variables](../README.md#environment) provided by all docker images.
