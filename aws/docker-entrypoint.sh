#!/bin/sh
set -e 

action=${1:-plan}
modules=/data

# Variables to include in the tfenv process
export TF_BUCKET="${NAMESPACE}-${STAGE}-terraform-state"

eval "$(tfenv)"

# Variables to exclude in the tfenv process
export TF_BUCKET_REGION=${AWS_REGION}
export TF_DYNAMODB_TABLE="${NAMESPACE}-${STAGE}-terraform-state-lock"

argName="-backend-config"
export TF_CLI_ARGS_init="${argName}=bucket=${TF_BUCKET} ${argName}=region=${AWS_REGION} ${argName}=encrypt=true"
export TF_CLI_ARGS_apply="-auto-approve"

for d in ${modules}/*/ ; do
  echo "Initializing $d"
  make -C $d init
  echo "Run $action on $d"
  make -C $d $action
  echo "Finishing $d"
  make -C $d clean
done
