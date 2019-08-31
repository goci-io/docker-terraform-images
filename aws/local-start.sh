#!/bin/bash

# Variables to include in the tfenv process
export TF_BUCKET="${NAMESPACE}-${STAGE}-terraform-state"
export TF_BUCKET_REGION=${AWS_REGION}

eval "$(tfenv)"

# Variables to exclude in the tfenv process
export TF_DYNAMODB_TABLE="${NAMESPACE}-${STAGE}-terraform-state-lock"

argName="-backend-config"
export TF_CLI_ARGS_init="${argName}=bucket=${TF_BUCKET} ${argName}=region=${AWS_REGION} ${argName}=encrypt=true"
export TF_IN_AUTOMATION=""
export TF_INPUT=1
export TF_CLI_ARG=""

/bin/bash
