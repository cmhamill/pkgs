.DEFAULT_GOAL = deb
.PHONY: deb clean

NAME = $(notdir $(CURDIR))
RELEASES_URL = https://releases.hashicorp.com/vault

meta-releases :
	@curl -s '$(RELEASES_URL)'/ \
	    | grep -v '<meta' \
	    | hxwls -b '$(RELEASES_URL)' | grep /vault | head -n 1 > $@

meta-release-url : meta-releases
	@curl -s "$$(cat $<)" \
	    | grep -v '<meta' \
	    | hxwls -b "$$(cat $<)" \
	    | grep linux_amd64 > $@

release.zip : meta-release-url
	@wget --quiet --no-use-server-timestamps -O $@ "$$(cat $<)"

release : release.zip
	@mkdir -p $@/usr/bin
	@unzip -q -d $@/usr/bin $@

deb : release
	@echo $(NAME): building...
	@fpm -s dir -t deb -n $(NAME) \
		--log error \
		--category admin \
		--version "$$(semver $$($</usr/bin/vault --version))" \
		--license 'MPL-2.0' \
		--url 'https://www.vaultproject.io/' \
		--description 'Vault secures, stores, and tightly controls access to tokens, passwords, certificates, API keys, and other secrets in modern computing.' \
		--vendor 'HashiCorp' \
		./release/=/
	@echo $(NAME): done.

clean :
	@rm -rf -- ./meta-* ./release* ./$(NAME)*.deb
