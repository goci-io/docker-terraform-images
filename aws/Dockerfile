# This image should not depend on inhouse images (except official public ones)
# Code in this project setups basic infrastructure for these things (eg: docker registry)
FROM alpine:3.10

RUN mkdir -p /conf/provider \
 && mkdir -p /data \
 && mkdir -p /var/lib/cache/terraform

RUN apk add --no-cache unzip make git bash python3

ADD https://releases.hashicorp.com/terraform/0.12.6/terraform_0.12.6_linux_amd64.zip /tmp/terraform_0.12.6_linux_amd64.zip
RUN unzip /tmp/terraform_0.12.6_linux_amd64.zip -d /usr/local/bin \
 && chmod +x /usr/local/bin/terraform

ADD https://github.com/cloudposse/tfenv/releases/download/0.4.0/tfenv_linux_amd64 /usr/local/bin/tfenv
RUN chmod +x /usr/local/bin/tfenv

ADD https://storage.googleapis.com/kubernetes-release/release/v1.13.9/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

RUN pip3 install awscli --upgrade --user --no-cache --no-warn-script-location \
 && mv ~/.local/bin/aws /usr/local/bin/aws

# Terraform CLI config and variables
ENV TF_INPUT 0
ENV TF_IN_AUTOMATION 1
ENV TF_CLI_ARGS "-no-color"
ENV TF_PROVIDER_AWS_VERSION "~> 2.24"
ENV TF_PROVIDER_K8S_VERSION "~> 1.8"
ENV TF_PLUGIN_CACHE_DIR /var/lib/cache/terraform

# Pre-Download Terraform provider
RUN echo "provider \"aws\" { version = \"${TF_PROVIDER_AWS_VERSION}\" }" > /conf/provider/aws.provider.tf \
 && echo "provider \"kubernetes\" { version = \"${TF_PROVIDER_K8S_VERSION}\" }" > /conf/provider/k8s.provider.tf \
 && cd /conf/provider && terraform init -backend=false \
 && rm -rf /conf/provider

COPY docker-entrypoint.sh /conf/docker-entrypoint.sh

VOLUME [ "/data" ]
VOLUME [ "/conf" ]

RUN rm -rf /tmp/*

ENTRYPOINT [ "/bin/bash", "/conf/docker-entrypoint.sh" ]
CMD ["apply"]
