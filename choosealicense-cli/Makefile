NAME = choosealicense-cli
INSTALL_LIB != python -c 'from distutils.sysconfig import get_python_lib; print get_python_lib()'

deb : clean
	fpm -s python -t deb -n $(NAME) \
	    --python-install-bin /usr/bin \
	    --python-install-lib $(INSTALL_LIB) \
	    $(NAME)

clean :
	rm -f -- ./$(NAME)*.deb
