.PHONY: deb clean

NAME = $(notdir $(CURDIR))

GEM_PREFIX != gem env gemdir

deb : clean
	@echo $(NAME): building...
	@fpm -s gem -t deb -n $(NAME) \
	    --log error \
	    --category ruby \
	    --gem-package-name-prefix ruby \
	    --gem-gem /usr/bin/gem \
	    --prefix $(GEM_PREFIX) \
	    --gem-bin-path /usr/bin \
	    $(subst ruby-, , $(NAME))
	@echo $(NAME): done.

clean :
	@rm -f -- ./$(NAME)*.deb
