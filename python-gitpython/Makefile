NAME = $(notdir $(CURDIR))

PYPI_NAME = GitPython
VERSIONS != apt-cache madison python-git | cut -d '|' -f 2 | sort -u
LICENSE != curl -s https://pypi.python.org/pypi/$(PYPI_NAME)/json | jq -r '.info.license' | cut -d ' ' -f 1
SUMMARY != curl -s https://pypi.python.org/pypi/$(PYPI_NAME)/json | jq -r '.info.summary'
URL != curl -s https://pypi.python.org/pypi/$(PYPI_NAME)/json | jq -r '.info.package_url'

deb : clean
	@echo $(NAME): building...
	@for v in $(VERSIONS); do \
	    fpm -s empty -t deb -n $(NAME) \
	    	-v $$(echo -n $$v | cut -d - -f 1) \
	    	--iteration $$(echo -n $$v | cut -d - -f 2) \
		--log error \
		--category python \
		--license $(LICENSE) \
		--url '$(URL)' \
		--description "$(SUMMARY)\nThis package is a dummy transitional package. It can be safely removed." \
		--depends "python-git = $$v" & \
	done; wait
	@echo $(NAME): done.

clean :
	@rm -f -- ./$(NAME)*.deb
