MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help

# all targets are phony
.PHONY: $(shell egrep -o ^[a-zA-Z_-]+: $(MAKEFILE_LIST) | sed 's/://')

HOST=http://localhost
PORT_AUTH=3000
PORT=4000
USER=john
PASSWORD=password123admin

# for external authentication
PORT_EXTERNAL=5000
HOST_EXTERNAL=http://localhost
USER_EXTERNAL=foo
PASSWORD_EXTERNAL=bar

ifneq ("$(wildcard ./.env)","")
  include ./.env
endif

run-auth: ## Run Authentication server
	@npm run start-auth

run: ## Run server
	@npm run start

run-external: ## Run server for external
	@npm run start-external

clean: ## Clean Package
	@rm -fr package-lock.json node_modules

install: clean ## Install package
	@npm install

login: ## Login
	@$(eval TOKEN := $(shell curl -s -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"username": "${USER}", "password": "${PASSWORD}"}' ${HOST}:${PORT_AUTH}/login|jq -r '.accessToken'))

get: login ##  ## Get data with token
	@curl -s -H "Authorization: Bearer ${TOKEN}" ${HOST}:${PORT}/books

login-external: ## Login to external
	@$(eval TOKEN := $(shell curl -s -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"username": "${USER_EXTERNAL}", "password": "${PASSWORD_EXTERNAL}"}' ${HOST_EXTERNAL}login/|jq -r '.access_token'))

get-external: login-external ## Get data with token by external
	@curl -s -H "Authorization: Bearer ${TOKEN}" ${HOST}:${PORT_EXTERNAL}/books

get-external-invalid-token: ## Get data invalid token
	@curl -s -H "Authorization: Bearer hogehoge" ${HOST}:${PORT_EXTERNAL}/books

help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
