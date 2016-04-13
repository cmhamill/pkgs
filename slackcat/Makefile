GH_USERNAME = vektorlab
include ../_lib/github-release.mk

release/build : release meta-description
	@patch $</config.go < config.patch
	@GOPATH=$(CURDIR)/release $(MAKE) -C release build
	@mv $@/$(NAME)-*-linux-amd64 $@/$(NAME)
	@help2man -N -n '$(shell cat meta-description)' -o $@/$(NAME).1 $@/$(NAME)

deb : release/build release meta-license meta-url meta-description meta-vendor
	@echo $(NAME): building...
	@fpm -s dir -t deb -n $(NAME) \
		--log error \
		--category net \
		--version "$$(cat release/VERSION)" \
		--license "$$(cat meta-license)" \
		--url "$$(cat meta-url)" \
		--description "$$(cat meta-description)" \
		--vendor  "$$(cat meta-vendor)" \
		./$</$(NAME)=/usr/bin/$(NAME) \
		./$</$(NAME).1=/usr/share/man/man1/$(NAME).1 \
		./release/LICENSE=/usr/share/doc/$(NAME)/LICENSE \
		./release/README.md=/usr/share/doc/$(NAME)/README.md
	@echo $(NAME): done.
