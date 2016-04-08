GH_USERNAME = jordansissel
include ../_lib/github-tag.mk

release-build : release meta-license
	mkdir -p $@/usr/lib/$(NAME) $@/usr/bin
	cd $< && GEM_PATH=$@/gem bundle install --without=development --standalone
	cd $< && gem build $(NAME).gemspec
	tar -xf $</fpm*gem -C $@
	tar --touch -xf $@/data.tar.gz -C $@/usr/lib/$(NAME)
	cp -pr $</bundle $@/usr/lib/$(NAME)/bundle
	echo "#!/usr/bin/ruby" > $@/usr/bin/fpm
	echo 'load File.dirname($$0) + "/../lib/fpm/bundle/bundler/setup.rb"' >> $@/usr/bin/fpm
	echo 'require "fpm"'  >> $@/usr/bin/fpm
	echo 'require "fpm/command"' >> $@/usr/bin/fpm
	echo 'exit(FPM::Command.run || 0)' >> $@/usr/bin/fpm
	chmod +x $@/usr/bin/fpm

deb : release-build meta-version meta-license meta-url meta-description meta-vendor
	@echo $(NAME): building...
	@fpm -s dir -t deb -n $(NAME) \
		--log error \
		--category ruby \
		--version "$$(cat meta-version)" \
		--license "$$(cat meta-license)" \
		--url "$$(cat meta-url)" \
		--description "$$(cat meta-description)" \
		--vendor  "$$(cat meta-vendor)" \
		-C $< usr
	@echo $(NAME): done.