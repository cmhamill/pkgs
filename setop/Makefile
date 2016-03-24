export npm_config_prefix=/usr

NAME = setop
LICENSE != npm view --json setop | jq .license
URL != npm view --json setop | jq .homepage

deb : clean
	fpm -s npm -t deb -n $(NAME) --license $(LICENSE) --url $(URL) $(NAME)

clean :
	rm -f -- ./$(NAME)*.deb
