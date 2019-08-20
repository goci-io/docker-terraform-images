
export NAMESPACE ?= goci
export CLOUD_PROVIDER ?= aws
export IMAGE_NAME ?= $(NAMESPACE)-terraform-$(CLOUD_PROVIDER)

init:
	# Do nothing

build:
	docker build -t $(IMAGE_NAME) $(CLOUD_PROVIDER)

run:
	docker run --entrypoint=/bin/bash -it $(IMAGE_NAME)