export npm_config_prefix=/usr

NAME = how2
LICENSE != npm view --json $(NAME) | jq .license
URL != npm view --json $(NAME) | jq .homepage

deb : clean
	fpm -s npm -t deb -n $(NAME) --license $(LICENSE) --url $(URL) $(NAME)

clean :
	rm -f -- ./$(NAME)*.deb
