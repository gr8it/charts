SHELL := /bin/bash

ifeq ($(strip $(CHARTFOLDER)),)
    CHARTFOLDER := $(CURDIR)
	CHARTFOLDERS := $(wildcard $(CHARTFOLDER)/../charts/*/)
else
	CHARTFOLDERS = $(addprefix $(CURDIR)/../charts/, $(CHARTFOLDER))	
endif

debug:
	@echo "$${REPO_USERNAME}"
	@echo "$${REPO_TOKEN}"
	@echo ${REPO_URL}

lint:
	@for folder in $(CHARTFOLDERS); do \
		echo "Chart lint in folder: $$folder "; \
		helm lint $$folder; \
	done

package:
	@for folder in $(CHARTFOLDERS); do \
		echo "Chart package in folder: $$folder "; \
		helm package $$folder -d $(CURDIR)/..; \
	done

index:
	echo "Charts index file ... "
	helm repo index $(CURDIR)/..

build: lint package index

publish:
	echo "Charts publish ... "
	helm repo add --force-update --username $${REPO_USERNAME} --password $${REPO_TOKEN} helm_charts_repo ${REPO_URL}
	@for name in $(CURDIR)/../*.tgz; do\
    	echo $${name}; \
		helm cm-push $${name} helm_charts_repo; \
	done

clean:
