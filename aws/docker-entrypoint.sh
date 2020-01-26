#!/bin/bash
set -e 

action=${1:-plan}
if [[ $action == "destroy" ]]; then
  modules=(`ls /data | sort -r`)
else
  modules=(`ls /data | sort`)
fi

if [[ "$TF_FLAT_MODULE" == "1" ]]; then
  modules=( "" )
fi

if (( ${#modules[@]} == 0 )); then
  echo "No modules found" >&2
  exit 1
fi

. /conf/env.sh

encryptArg="-backend-config=encrypt=true"
bucketArg="-backend-config=bucket=${TF_BUCKET}"
regionArg="-backend-config=region=${AWS_REGION}"
dynamodbArg="-backend-config=dynamodb_table=${TF_DYNAMODB_TABLE}"

export TF_CLI_ARGS_init="-no-color ${bucketArg} ${regionArg} ${encryptArg} ${dynamodbArg}"
export TF_CLI_ARGS_apply="-no-color -auto-approve plan.tfstate"
export TF_CLI_ARGS_destroy="-no-color -auto-approve"
export TF_CLI_ARGS_plan="-no-color -out plan.tfstate"

# Execute modules
for d in ${modules[@]} ; do
  echo -e "\n"
  cd /data/$d
  make init
  
  if [[ "$action" == "apply" ]]; then
    make plan
  fi

  make $action
  make clean
done
