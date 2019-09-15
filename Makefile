mkfile_dir := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

export NAMESPACE ?= goci
export STAGE ?= staging
export REGION ?= eu1
export CLOUD_PROVIDER ?= aws
export IMAGE_NAME ?= $(NAMESPACE)-terraform-$(CLOUD_PROVIDER)

init:
	# Do nothing

build:
	docker build -t $(IMAGE_NAME) $(CLOUD_PROVIDER)

run:
	# Additional environment variables are usually required
	docker run --entrypoint=/conf/local-start.sh \
		-e NAMESPACE \
		-e STAGE \
		-e REGION \
		-e AWS_REGION=eu-central-1 \
		-v $(HOME)/.aws:/root/.aws:ro \
		-v $(HOME)/.awsvault:/root/.awsvault \
		-v $(mkfile_dir)/examples/$(CLOUD_PROVIDER):/data \
		-it $(IMAGE_NAME)

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
