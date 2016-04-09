NAME = $(notdir $(CURDIR))

PYTHON_INSTALL_LIB != python3 -c 'from distutils.sysconfig import get_python_lib; print(get_python_lib())'

deb : clean
	@echo $(NAME): building...
	@runlock -t 20 -- fpm -s python -t deb -n $(NAME) \
	    --log error \
	    --category python \
	    --python-bin /usr/bin/python3 \
	    --python-install-bin /usr/bin \
	    --python-install-lib $(PYTHON_INSTALL_LIB) \
	    --python-package-name-prefix python3 \
	    --depends python3-xdg --python-disable-dependency pyxdg \
	    --depends python3-tz --python-disable-dependency pytz \
	    --depends vdirsyncer --python-disable-dependency vdirsyncer \
	    $(subst python3-, , $(NAME))
	@echo $(NAME): done.

clean :
	@rm -f -- ./$(NAME)*.deb
