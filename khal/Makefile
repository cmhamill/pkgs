NAME = $(notdir $(CURDIR))

PYTHON_INSTALL_LIB != python -c 'from distutils.sysconfig import get_python_lib; print get_python_lib()'

deb : clean
	@echo $(NAME): building...
	@runlock -t 20 -- fpm -s python -t deb -n $(NAME) \
	    --log error \
	    --category python \
	    --python-install-bin /usr/bin \
	    --python-install-lib $(PYTHON_INSTALL_LIB) \
	    --depends python-xdg --python-disable-dependency pyxdg \
	    --depends python-tz --python-disable-dependency pytz \
	    --depends vdirsyncer --python-disable-dependency vdirsyncer \
	    $(subst python-, , $(NAME))
	@echo $(NAME): done.

clean :
	@rm -f -- ./$(NAME)*.deb
