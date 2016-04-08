NAME = $(notdir $(CURDIR))
GH_USERNAME = shyiko
include ../_lib/github-release.mk

deb : release meta-version meta-license meta-url meta-description meta-vendor
	@echo $(NAME): building...
	@fpm -s dir -t deb -n $(NAME) \
	    --log error \
	    --category shells \
	    --version "$$(cat meta-version)" \
	    --license "$$(cat meta-license)" \
	    --url "$$(cat meta-url)" \
	    --description "$$(cat meta-description)" \
	    --vendor  "$$(cat meta-vendor)" \
	    ./release/commacd.bash=/usr/share/commacd/commacd.bash \
	    ./release/readme.md=/usr/share/doc/commacd/readme.md
	@echo $(NAME): done.
