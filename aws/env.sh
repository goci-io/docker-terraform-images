#!/bin/bash

if [[ -z "$TF_BUCKET" ]]; then
    export TF_BUCKET_REGION=${AWS_REGION}
    export TF_BUCKET="${NAMESPACE}-${STAGE}-terraform-state"
    export TF_DYNAMODB_TABLE="${NAMESPACE}-${STAGE}-terraform-state-lock"
fi

if [[ -z "$KOPS_CLUSTER_NAME" ]]; then
    export KOPS_STATE_STORE="s3://${NAMESPACE}-${STAGE}-kops-state-${REGION}"
    export KOPS_CLUSTER_NAME="${STAGE}.${REGION}.${NAMESPACE}.${CLUSTER_TLD:-io}"
fi

if [[ ! -z "$AWS_ASSUME_ROLE_NAME" ]]; then
    export AWS_ASSUME_ROLE_ARN="arn:aws:iam::${AWS_ACCOUNT_ID}:role/${AWS_ASSUME_ROLE_NAME}"
fi

eval "$(tfenv)"
