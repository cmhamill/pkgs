NAME = $(notdir $(CURDIR))
TARBALL != curl -s https://api.github.com/repos/shyiko/commacd/releases/latest | jq -r .tarball_url

deb : release man clean-deb
	fpm -s dir -t deb -n $(NAME) \
	    --log error \
	    --category shells \
	    ./release/commacd.bash=/usr/share/commacd/commacd.bash \
	    ./release/readme.md=/usr/share/doc/commacd/readme.md \
	    ./release/commacd.1=/usr/share/man/man1/commacd.1

clean : clean-deb
	@rm -rf -- ./release*

clean-deb :
	@rm -rf ./$(NAME)*.deb

man : release
	go-md2man -in release/readme.md -out release/commacd.1

release : release.tar.gz
	tar xf release.tar.gz && mv shyiko-commacd-* release

release.tar.gz :
	wget --quiet -O release.tar.gz $(TARBALL)

