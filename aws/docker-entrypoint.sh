#!/bin/bash
set -e 

action=${1:-plan}
if [[ $action == "destroy" ]]; then
  modules=(`ls /data | sort -r`)
else
  modules=(`ls /data | sort`)
fi

if (( ${#modules[@]} == 0 )); then
  echo "No modules found" >&2
  exit 1
fi

. /conf/env.sh

# Variables to exclude in the tfenv process

argName="-backend-config"
export TF_CLI_ARGS_init="${argName}=bucket=${TF_BUCKET} ${argName}=region=${AWS_REGION} ${argName}=encrypt=true"
export TF_CLI_ARGS_apply="-auto-approve plan.tfstate"
export TF_CLI_ARGS_destroy="-auto-approve"
export TF_CLI_ARGS_plan="-out plan.tfstate"

# Execute modules
for d in ${modules[@]} ; do
  echo -e "\n"
  echo "Initializing $d"
  make -C /data/$d init
  
  if [[ "$action" == "apply" ]]; then
    make -C /data/$d plan
  fi

  echo "Run $action on $d"
  make -C /data/$d $action
  echo "Finishing $d"
  make -C /data/$d clean
done
