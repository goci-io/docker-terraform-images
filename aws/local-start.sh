#!/bin/bash

. /conf/env.sh

argName="-backend-config"
export TF_CLI_ARGS_init="${argName}=bucket=${TF_BUCKET} ${argName}=region=${AWS_REGION} ${argName}=encrypt=true"
export TF_IN_AUTOMATION=""
export TF_INPUT=1
export TF_CLI_ARG=""

/bin/bash
