LATEST_TAG ?= latest
IMAGE_NAME=eos-local
DOCKER_REGISTRY=eoscostarica506
VERSION ?= $(shell git rev-parse --short HEAD)

run: ##@devops Run the docker image
run:
	@echo "Running $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(LATEST_TAG)"
	@docker run -dp 8888:8888 $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(LATEST_TAG)

build-docker: ##@devops Build the docker image
build-docker: ./Dockerfile
	echo "Building docker container ..."
	$(eval -include .env)
	@docker pull $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(VERSION) || true
	@docker build \
		-t $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(VERSION) \
		-t $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(LATEST_TAG) \
		--build-arg testnet_eosio_private_key=$(TESTNET_EOSIO_PRIVATE_KEY) \
		--build-arg testnet_eosio_public_key=$(TESTNET_EOSIO_PUBLIC_KEY) \
		.

push-image: ##@devops Push the freshly built image and tag with release or latest tag
push-image:
	@docker push $(DOCKER_REGISTRY)/$(IMAGE_NAME):$(LATEST_TAG)
