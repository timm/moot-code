SHELL     := bash
MAKEFLAGS += --warn-undefined-variables
.SILENT:

Top=$(shell git rev-parse --show-toplevel)

help: ## print help
	printf "\nmake [OPTIONS]\n\nOPTIONS:\n"
	grep -E '^[a-zA-Z_\.-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "} {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'

pull: ## download
	git pull

push: ## save
	echo -en "Why this push? "; read x; git commit -am "$$x"; git push; git status


