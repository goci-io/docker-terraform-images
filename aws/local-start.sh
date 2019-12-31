#!/bin/bash

. /conf/env.sh

argName="-backend-config"
export TF_CLI_ARGS_init="${argName}=bucket=${TF_BUCKET} ${argName}=region=${AWS_REGION} ${argName}=encrypt=true"
export TF_IN_AUTOMATION=""
export TF_INPUT=1

if [[ "$AWS_VAULT_ENABLED" != "false" ]]; then
    echo "Installing and setting up aws-vault"
    sudo curl -L -o /usr/local/bin/aws-vault https://github.com/99designs/aws-vault/releases/download/v4.2.0/aws-vault-linux-amd64

    export AWS_PROFILE=${AWS_PROFILE:-"$NAMESPACE-$STAGE"}
    export AWS_DEFAULT_PROFILE=${AWS_PROFILE}

    export AWS_VAULT_ENABLED=true
    export AWS_VAULT_SERVER_ENABLED=false
    export AWS_VAULT_BACKEND=file

    echo "Spawing bash using aws-vault $AWS_PROFILE"
    echo "Please unlock your stored aws-vault key"
    aws-vault exec ${AWS_PROFILE} -- /bin/bash
else
    /bin/bash
fi
