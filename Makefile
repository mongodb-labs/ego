PACKAGE_NAME=ego

default: build

gitsha := $(shell git log -n1 --pretty='%h')
version=$(shell git describe --exact-match --tags "$(gitsha)" 2>/dev/null)
ifeq ($(version),)
	version := $(gitsha)
endif
version := $(version)-$(shell git diff --quiet || echo 'dirty')
.PHONY: build
build: clean
	@echo "Building image..."
	@docker build -t $(PACKAGE_NAME):$(version) .

.PHONY: clean
clean:
	@echo "Removing existing images..."
	-docker rmi -f $(PACKAGE_NAME):$(version)

.PHONY: exec
exec:
	@echo $(PACKAGE_NAME):$(version)
