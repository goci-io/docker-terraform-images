FROM alpine:3.10

RUN mkdir -p /conf/provider \
 && mkdir -p /data \
 && mkdir -p /localhost \
 && mkdir -p /var/lib/cache/terraform

COPY packages.txt /etc/apk/packages.txt
RUN echo "@testing https://alpine.global.ssl.fastly.net/alpine/edge/testing" >> /etc/apk/repositories \
 && apk add --update --no-cache $(grep -v '^#' /etc/apk/packages.txt)

LABEL org.label-schema.name="terraform-k8s-aws" \
      org.label-schema.description="Terraform image to provision infrastructure on AWS with kops" \
      org.label-schema.vcs-url="https://github.com/goci-io/docker-terraform-images" \
      org.label-schema.url="https://goci.io/" \
      org.label-schema.vendor="goci.io" \
      org.label-schema.version="1.6" \
      org.label-schema.schema-version="1.0"

ENV TERRAFORM_VERSION "0.12.20"
ENV KUBERNETES_VERSION "1.15.10"
ENV KUBECTL_VERSION "1.15.10"
ENV KOPS_VERSION "1.15.2"
ENV HELM_VERSION "3.1.0"

ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip /tmp/terraform.zip
RUN unzip /tmp/terraform.zip -d /usr/local/bin \
 && chmod +x /usr/local/bin/terraform

ADD https://github.com/cloudposse/tfenv/releases/download/0.4.0/tfenv_linux_amd64 /usr/local/bin/tfenv
RUN chmod +x /usr/local/bin/tfenv

ADD https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

ADD https://github.com/kubernetes/kops/releases/download/${KOPS_VERSION}/kops-linux-amd64 /usr/local/bin/kops
RUN chmod +x /usr/local/bin/kops

ADD https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz /tmp/helm.tar.gz
COPY terraform-provider-helm /var/cache/terraform/linux_amd64/terraform-provider-helm_v0.10.4_x4

RUN cd /tmp && tar -zxvf /tmp/helm.tar.gz \
 && mv /tmp/linux-amd64/helm /usr/local/bin/helm \
 && chmod +x /usr/local/bin/helm \
 && helm repo add stable https://kubernetes-charts.storage.googleapis.com \
 && helm repo update

RUN pip3 install awscli --upgrade --user --no-cache --no-warn-script-location \
 && mv ~/.local/bin/aws /usr/local/bin/aws

# Terraform CLI config and variables
# Setup -no-color per command due to https://github.com/hashicorp/terraform/issues/14847
ENV TF_INPUT 0
ENV TF_IN_AUTOMATION 1
ENV TF_PLUGIN_CACHE_DIR /var/cache/terraform

COPY env.sh /conf/env.sh
COPY docker-entrypoint.sh /conf/docker-entrypoint.sh
COPY local-start.sh /conf/local-start.sh

VOLUME [ "/data" ]
VOLUME [ "/conf" ]

RUN rm -rf /tmp/*

ENTRYPOINT [ "/bin/bash", "/conf/docker-entrypoint.sh" ]
