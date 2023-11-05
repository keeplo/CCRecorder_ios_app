SWIFTLINT_PATH := $(shell which swiftlint)

install:
	@make close_xcode
	@echo "\033[34m[1/6] Running 'tuist clean'...\033[39m"
	@make clean
	@echo "\033[34m[2/6] Running 'tuist fetch'...\033[39m"
	@make fetch
	@echo "\033[34m[3/6] Running 'tuist generate'...\033[39m"
	@make generate
#	@echo "\033[34m[4/6] Running 'pod_install'...\033[39m"
#	@make pod_install
	@echo "\033[34m[5/6] Running 'tuist graph'...\033[39m"
	@make depency_graph
	@echo "\033[34m[6/6] Running 'open Xcode'...\033[39m"
	@make open_xcode
	@echo "\033[32mCompleted!\033[39m"

clean:
	@tuist clean

edit:
	@tuist edit

fetch:
	tuist fetch

depency_graph:
	tuist graph -t

generate:
	@TUIST_ROOT_DIR=$(SWIFTLINT_PATH) tuist generate --no-open

#pod_install:
#	@pod install --repo-update
	
open_xcode:
	@open CCRecorderApps.xcworkspace
	
close_xcode:
	-@pkill -x Xcode
