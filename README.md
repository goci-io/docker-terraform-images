# docker-terraform-images

#### Maintained by [@goci-io/core](https://github.com/orgs/goci-io/teams/core)

This repository contains Dockerfiles to build a version pinned environment to plan and apply terraform.

## Overview

- [terraform-k8s-aws](aws/README.md), [latest tags](https://hub.docker.com/r/gocidocker/terraform-k8s-aws/tags)


This repository uses hub.docker.com's autobuild configuration. Find our images [here](https://hub.docker.com/u/gocidocker).

In general these docker images are designed to provision a kubernetes (kops) cluster on a specific hosting provider. They also provide an environment where [terraform modules](https://github.com/search?q=topic%3Aterraform+org%3Agoci-io+fork%3Atrue) from [goci.io](https://goci.io) can be executed with ease and full binary support.  

## Usage

The following environment variables are generally used to provide runtime specific details:

| Name | Description |
|-----------|-----------------------------------------------------------|
| NAMESPACE | The namespace for this configuration (eg: goci) |
| STAGE | The stage this configuration is for (eg: staging or prod) |
| REGION | The region this configuration is for (eg: eu1) |

In addition you may need to put some extra environment variables into place for the cloud provider to work as expected.

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
    -i gocidocker/terraform-k8s-aws:v1.3 \
    [apply|plan|destroy]
```

Please check for latest versions on hub.docker.com or under [releases](https://github.com/goci-io/docker-terraform-images/releases). Note the cloud provider suffix (eg: `-aws`). The docker tag is named equally to the version without the provider suffix.
