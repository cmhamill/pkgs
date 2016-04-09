.DEFAULT_GOAL = deb
.PHONY: deb clean

NAME = $(notdir $(CURDIR))
RELEASES_URL = https://releases.hashicorp.com/terraform

meta-releases :
	@curl -s '$(RELEASES_URL)'/ \
	    | grep -v '<meta' \
	    | hxwls -b '$(RELEASES_URL)' | grep /terraform | head -n 1 > $@

meta-release-url : meta-releases
	@curl -s "$$(cat $<)" \
	    | grep -v '<meta' \
	    | hxwls -b "$$(cat $<)" \
	    | grep linux_amd64 > $@

release.zip : meta-release-url
	@wget --quiet --no-use-server-timestamps -O $@ "$$(cat $<)"

release : release.zip
	@mkdir -p $@/usr/bin $@/usr/share/man/man1 tmp-binstubs
	@unzip -q -d $@/usr/bin $@
	@help2man -N "$@/usr/bin/terraform" -o "$@/usr/share/man/man1/terraform.1"
	@for cmd in $$($@/usr/bin/terraform -help | grep '^\s\+' \
	    		| awk '{printf $$1"\n"}' | grep -v version); do \
	    echo '#!/bin/sh' >> "tmp-binstubs/terraform-$$cmd"; \
	    echo "$@/usr/bin/terraform \$$1 $$cmd" >> "tmp-binstubs/terraform-$$cmd"; \
	    chmod +x "tmp-binstubs/terraform-$$cmd"; \
	    help2man -n "terraform $$cmd" -N "tmp-binstubs/terraform-$$cmd" -o "$@/usr/share/man/man1/terraform-$$cmd.1"; \
	done
	@rm -rf -- tmp-binstubs

deb : release
	@echo $(NAME): building...
	fpm -s dir -t deb -n $(NAME) \
		--log error \
		--category admin \
		--version "$$(semver $$($</usr/bin/terraform -version))" \
		--license 'MPL-2.0' \
		--url 'https://www.terraform.io/' \
		--description 'Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently.' \
		--vendor 'HashiCorp' \
		./release/=/
	@echo $(NAME): done.


clean :
	@rm -rf -- ./meta-* ./release* ./$(NAME)*.deb
