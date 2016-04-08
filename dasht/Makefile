GH_USERNAME = sunaku
include ../_lib/github-release.mk

deb : release meta-version meta-license meta-url meta-description meta-vendor
	@echo $(NAME): building...
	@fpm -s dir -t deb -n dasht \
		--log error \
		--category doc \
		--version "$$(cat meta-version)" \
		--license "$$(cat meta-license)" \
		--url "$$(cat meta-url)" \
		--description "$$(cat meta-description)" \
		--vendor  "$$(cat meta-vendor)" \
		--depends sqlite3 \
		--depends wget \
		--depends w3m \
		--depends socat \
		./release/bin/=/usr/bin \
		./release/man/=/usr/share/man \
		./release/LICENSE=/usr/share/doc/dasht/LICENSE \
		./release/README.md=/usr/share/doc/dasht/README.md \
		./release/VERSION.md=/usr/share/doc/dasht/VERSION.md
	@echo $(NAME): done.
