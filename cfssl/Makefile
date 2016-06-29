.DEFAULT_GOAL = deb
.PHONY: deb clean

NAME = $(notdir $(CURDIR))
SRC_BASE= github.com/cloudflare/cfssl/cmd
export GOPATH=$(CURDIR)/build

build:
	@mkdir -p $@ && cd $@ && go get -u \
	    $(SRC_BASE)/cfssl \
	    $(SRC_BASE)/cfssljson \
	    $(SRC_BASE)/mkbundle \
	    $(SRC_BASE)/multirootca

meta-version: build
	@$</bin/cfssl version | grep ^Version | cut -d ' ' -f 2 > $@
	    
release : build
	@mkdir -p $@/usr/bin $@/usr/share/doc/$(NAME)
	@cp $</bin/* $@/usr/bin/
	@cp $</src/$(SRC_BASE)/../README.md $@/usr/share/doc/$(NAME)/
	@cp -r $</src/$(SRC_BASE)/../doc/* $@/usr/share/doc/$(NAME)/
	@mv $@/usr/share/doc/$(NAME)/README.txt $@/usr/share/doc/$(NAME)/index.txt


deb : release meta-version
	@echo $(NAME): building...
	fpm -s dir -t deb -n $(NAME) \
		--log error \
		--category admin \
		--version "$$(cat meta-version)" \
		--license 'BSD-2-clause' \
		--url 'https://cfssl.org/' \
		--description "CFSSL is CloudFlare's PKI/TLS swiss army knife. It is both a command line tool and an HTTP API server for signing, verifying, and bundling TLS certificates." \
		--vendor 'CloudFlare' \
		./release/=/
	@echo $(NAME): done.

clean :
	@rm -rf -- ./build ./meta-* ./release* ./$(NAME)*.deb
