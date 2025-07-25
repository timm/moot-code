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

sh: ## launch interactive bash with custom prompt
	@bash --rcfile <(cat <<-'EOF'
	bold="\[\e[1m\]"
	col0="\[\e[0m\]"
	col1="\[\e[36m\]"
	col2="\[\e[35m\]"
	Xdir="x"

branch() {
	git rev-parse --abbrev-ref HEAD 2>/dev/null
}

PROMPT_COMMAND='
	pdir=$$(basename "$$(dirname "$$PWD")");
	cdir=$$(basename "$$PWD");
	gbr=$$(branch);
	PS1="👀 $${bold}$${col1}$${Xdir}$${col0} $${col1}$${pdir}/$${bold}$${cdir}$${col0} $${col2}$${gbr}$${col0} ▶ "
'
EOF
	) -i


