#
# Makefile to simplify project workflow
#

default: help

#
# EXAMPLE MULTIPLE SUBCOMMANDS
#
EXAMPLE_CMDS=
EXAMPLE_CMDS_IGERR=

eq :     ## eq help info
EXAMPLE_CMDS+=eq

lt :   ## lt little than
EXAMPLE_CMDS+=lt

ge:     ## ge greater or equal
EXAMPLE_CMDS_IGERR+=ge


$(EXAMPLE_CMDS):
	test 1 -$@ 2

$(EXAMPLE_CMDS_IGERR):
	-test 1 -$@ 2

#
# EXAMPLE NORMAL COMMAND
#
example:   ## Text help for example command
	echo Text help
	echo Second line


#
# Help magic
#
help: ## show help message
	@awk \
	'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} \
	/^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } \
	/^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' \
	$(MAKEFILE_LIST)

