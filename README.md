# docker-terraform-images

#### Maintained by [@goci-io/core](https://github.com/orgs/goci-io/teams/core)

This repository contains Dockerfiles to build a version pinned environment to plan and apply terraform.

## Overview

- [terraform-k8s-aws](aws), [latest tags](https://hub.docker.com/r/gocidocker/terraform-k8s-aws/tags)


This repository uses hub.docker.com's autobuild configuration. Find our images [here](https://hub.docker.com/u/gocidocker).

## Usage

The following environment variables are generally used to provide runtime specific details:

| Name | Description |
|-----------|-----------------------------------------------------------|
| NAMESPACE | The namespace for this configuration (eg: goci) |
| STAGE | The stage this configuration is for (eg: staging or prod) |
| REGION | The region this configuration is for (eg: eu1) |

In addition you may need to put some extra environment variables into place for the cloud provider to work as expected.

The entrypoint of our docker images executes an apply on all subdirectories in the `/data` folder (volume). 
You can specify the order in which modules are applied by prefixing the subdirectories with numbers for example.

To overwrite the terraform action executed on the modules, change the commands passed to the entrypoint.

#### Example

This example runs terraform plan or apply on AWS:

```
docker run -e NAMESPACE=$(NAMESPACE) \
    -e STAGE=$(STAGE) \
    -e REGION=$(REGION) \
    -e AWS_REGION \
    -e AWS_DEFAULT_REGION \
    -e AWS_CONTAINER_CREDENTIALS_RELATIVE_URI \
    -v <path_to_modules_dir>:/data \
    -i gocidocker/terraform-k8s-aws:v1.0 \
    [apply|plan]
```

Please check for latest versions on hub.docker.com or under [releases](https://github.com/goci-io/docker-terraform-images/releases). Note the cloud provider suffix (eg: `-aws`). The docker tag is named equally to the version without the provider suffix.
