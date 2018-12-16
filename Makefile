SHELL = /bin/sh
.SUFFIXES:
.SUFFIXES: .c .o
.PHONY: help
.DEFAULT_GOAL := help

# Go parameters
BIN_FOLDER=$(shell pwd)/bin
APP_FOLDER=$(shell pwd)/cmd/helloworld
APP_NAME=helloworld

# Docker parameters
NS ?= pfillion
VERSION ?= latest
IMAGE_NAME ?= helloworld
CONTAINER_NAME ?= helloworld
CONTAINER_INSTANCE ?= default

help: ## Show the Makefile help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

go-get:
	go get -v gotest.tools/assert

go-build: ## Build go app
	make go-get
	go build -o $(BIN_FOLDER)/$(APP_NAME) -v $(APP_FOLDER)

go-rebuild: ## Rebuild go app
	make go-clean
	make go-build

go-test: ## Test go app
	make go-get
	go test -v ./...

go-clean: ## Clean go app
	go clean
	rm -f $(BIN_FOLDER)/$(APP_NAME)

go-run: ## Run go app
	make go-build
	$(BIN_FOLDER)/$(APP_NAME)

docker-build: ## Build the image form Dockerfile
	docker build -t $(NS)/$(IMAGE_NAME):$(VERSION) -f Dockerfile .

docker-rebuild: ## Rebuild the image form Dockerfile
	docker build --no-cache -t $(NS)/$(IMAGE_NAME):$(VERSION) -f Dockerfile .

docker-push: ## Push the image to a registry
	docker push $(NS)/$(IMAGE_NAME):$(VERSION)
    
docker-shell: ## Run shell command in the container
	docker run --rm --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) -i -t $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION) /bin/sh

docker-run: ## Run the container
	docker run --rm --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION)

docker-start: ## Run the container in background
	docker run -d --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION)

docker-stop: ## Stop the container
	docker stop $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)

docker-rm: ## Remove the container
	docker rm $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)

build: ## Build all
	make go-build
	make docker-build

rebuild: ## Build all
	make go-rebuild
	make docker-rebuild

run: ## Run all
	make go-run
	make docker-run

test: ## Run all tests
	make go-test

release: ## Build and push the image to a registry
	make build
	make test
	make docker-push