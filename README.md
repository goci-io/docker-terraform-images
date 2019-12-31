# docker-terraform-images

#### Maintained by [@goci-io/core](https://github.com/orgs/goci-io/teams/core)

This repository contains Dockerfiles to build a version pinned environment to plan and apply terraform.

## Overview

- [terraform-k8s-aws](aws/README.md), [latest tags](https://hub.docker.com/r/gocidocker/terraform-k8s-aws/tags)


This repository uses hub.docker.com's autobuild configuration. Find our images [here](https://hub.docker.com/u/gocidocker).

In general these docker images are designed to provision a kubernetes (kops) cluster on a specific hosting provider. They also provide an environment where [terraform modules](https://github.com/search?q=topic%3Aterraform+org%3Agoci-io+fork%3Atrue) from [goci.io](https://goci.io) can be executed with ease and full binary support.  

## Usage

The following environment variables are generally needed to provide runtime specific details:

| Name | Description |
|-----------|--------------------------------------------------------|
| NAMESPACE | The namespace for this configuration (eg: goci) |
| STAGE | The stage this configuration is for (eg: staging or prod) |
| REGION | The region this configuration is for (eg: eu1) |

In addition you may need to put some extra environment variables into place for the cloud provider to work as expected.
By default `.io` is used as cluster top level domain. The TLD is used for the cluster name for example. You can overwrite the cluster TLD by setting `CLUSTER_TLD`.

### Environment

| Name | Description |
|-----------|--------------------------------------------------------|
| TERRAFORM_VERSION | Version of terraform used |
| KUBECTL_VERSION | Version of kubectl used |
| KOPS_VERSION | If kops is managing cluster resources the version used |
| HELM_VERSION | Kubernetes package manager version used |
| TF_CLI_ARGS_apply | `-auto-approve plan.tfstate` |
| TF_CLI_ARGS_destroy | `-auto-approve` |
| TF_CLI_ARGS_plan | `-out plan.tfstate` |
| KOPS_STATE_STORE | Reference to S3 bucket with kops state store (`<namespace>-<stage>-kops-state-<region>`) |
| KOPS_CLUSTER_NAME | Name of the kops managed cluster (`<stage>.<region>.<namespace>.<cluster_tld>`) |

These variables can also be accessed using terraform variables (lower case names).

### Add new module
The entrypoint of our docker images executes an apply on all subdirectories in the `/data` folder (volume). 
You can specify the order in which modules are applied by prefixing the subdirectories with numbers for example.

Each module requires a Makefile in the root with the following commands:
```
    init    Initialize or download module
    plan    Run terraform plan
    apply   Apply terraform plan
    destroy Destroy provisioned resources
    clean   Clean up dist files
```

To plan terraform code it is sufficient to just run `terraform plan`. All necessary configurations are passed to the CLI by default within the docker container.

**Important:** You need to specify under which path/key the module should save its state file. Whenever you are running `terraform init` you need to pass `-backend-config=key=<module-name>/terraform.tfstate` to avoid collisions.

To overwrite the terraform action executed on the modules, change the commands passed to the entrypoint. When executing with `destroy` action the modules are destroyed in the reverse order.

#### Example

This example runs terraform plan or apply on AWS:

```
docker run \
    -e NAMESPACE \
    -e STAGE \
    -e REGION \
    -e AWS_REGION \
    -e AWS_DEFAULT_REGION \
    -e AWS_CONTAINER_CREDENTIALS_RELATIVE_URI \
    -v <path_to_modules_dir>:/data \
    -i gocidocker/terraform-k8s-aws:v1.5 \
    [apply|plan|destroy]
```

Please check for latest versions on hub.docker.com or under [releases](https://github.com/goci-io/docker-terraform-images/releases). Note the cloud provider suffix (eg: `-aws`). The docker tag is named equally to the version without the provider suffix.


### Contribution

We are always happy to get feedback and support on improving the docker images and keeping binaries up to date.
Releases are done by the maintainer of this repository. A merge into the master will be considered to be in the upcoming release except there is already a stable and tested preview release available which does not require the changes.

