.DEFAULT_GOAL = deb
.PHONY: deb clean

NAME = $(notdir $(CURDIR))

SOURCE_URL = https://github.com/mbrubeck/compleat

src :
	@git clone '$(SOURCE_URL)' $@

configure : src
	@cd $< && ./Setup.lhs configure \
	    --prefix '$(CURDIR)/release/' \
	    --docdir '$(CURDIR)/release/share/doc/$(NAME)/' \
	    --datadir '$(CURDIR)/release/share/' --datasubdir '$(NAME)'

release : configure
	@cd src && ./Setup.lhs build && ./Setup.lhs install

deb : release
	@echo $(NAME): building...
	@fpm -s dir -t deb -n $(NAME) \
	    --log error \
	    --category shells \
	    --version "$$(grep ^Version: src/compleat.cabal | awk '{ printf $$2 }')" \
	    --license "$$(grep ^License: src/compleat.cabal | awk '{ printf $$2 }')" \
	    --url '$(SOURCE_URL)' \
	    --description "$$(grep ^Description: src/compleat.cabal | \
	    			awk '{ $$1="";$$0=$$0; } NF=NF')" \
	    --vendor "$$(grep ^Author: src/compleat.cabal | \
	    			awk '{ $$1="";$$0=$$0; } NF=NF')" \
	    ./release/=/usr
	@echo $(NAME): done.

clean :
	@rm -rf -- ./$(NAME)*.deb ./release* ./src*
