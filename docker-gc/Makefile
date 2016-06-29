deb: release
	@cd $< && debuild -us -uc -b

release:
	@git clone https://github.com/spotify/docker-gc.git release

clean: 
	@rm -rf -- ./release ./docker-gc*
