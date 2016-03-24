export npm_config_prefix=/usr

NAME = parse-columns
LICENSE != npm view --json setop | jq .license
URL != npm view --json setop | jq .homepage

deb : clean
	fpm -s npm -t deb -n $(NAME) --license $(LICENSE) --url $(URL) $(NAME)-cli

clean :
	rm -f -- ./$(NAME)*.deb
