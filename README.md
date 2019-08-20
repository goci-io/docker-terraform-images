# docker-terraform-images

#### Maintained by [@goci-io/core](https://github.com/orgs/goci-io/teams/core)

This repository contains Dockerfiles to build a version pinned environment to plan and apply terraform.

## Overview

- [terraform-aws](aws), [latest tags](https://hub.docker.com/r/gocidocker/goci-terraform-aws/tags)


## Usage

The following environment variables are generally used to provide runtime specific details:

| Name | Description |
|-----------|-----------------------------------------------------------|
| NAMESPACE | The namespace for this configuration (eg: goci) |
| STAGE | The stage this configuration is for (eg: staging or prod) |
| REGION | The region this configuration is for (eg: eu1) |

In addition you may need to put some extra environment variables into place for the cloud provider to work as expected.

The entrypoint of our docker images executes a plan on all subdirectories in the `/data` folder (volume). 
You can specify the order in which modules are applied by prefixing the subdirectories with numbers for example.