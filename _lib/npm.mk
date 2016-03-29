.PHONY: deb clean

NAME = $(notdir $(CURDIR))

LICENSE != npm view --json $(NAME) | jq .license
URL != npm view --json $(NAME) | jq .homepage

deb : clean
	@echo $(NAME): building...
	@fpm -s npm -t deb -n $(NAME) \
	    --log error \
	    --category web \
	    --license $(LICENSE) \
	    --url $(URL) \
	    --prefix /usr \
	    $(subst node-, , $(NAME))
	@echo $(NAME): done.

clean :
	@rm -f -- ./$(NAME)*.deb
