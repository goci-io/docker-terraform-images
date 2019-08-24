mkfile_dir := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

export NAMESPACE ?= goci
export CLOUD_PROVIDER ?= aws
export IMAGE_NAME ?= $(NAMESPACE)-terraform-$(CLOUD_PROVIDER)

init:
	# Do nothing

build:
	docker build -t $(IMAGE_NAME) $(CLOUD_PROVIDER)

run:
	docker run --entrypoint=/bin/bash -it $(IMAGE_NAME)

test:
	docker run \
		-e NAMESPACE=goci \
		-e STAGE=testing \
		-e REGION=eu1 \
		-v $(mkfile_dir)/examples/$(CLOUD_PROVIDER):/data \
		-i $(IMAGE_NAME) \
		apply
	docker run \
		-e NAMESPACE=goci \
		-e STAGE=testing \
		-e REGION=eu1 \
		-v $(mkfile_dir)/examples/$(CLOUD_PROVIDER):/data \
		-i $(IMAGE_NAME) \
		destroy