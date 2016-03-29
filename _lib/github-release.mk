.DEFAULT_GOAL = deb

NAME = $(notdir $(CURDIR))
GH_API = https://api.github.com

meta-gh-user.json:
ifndef GH_USERNAME
    $(error GH_USERNAME is undefined)
endif
	@curl -s $(GH_API)/users/$(GH_USERNAME) > $@

meta-repo.json :
ifndef GH_USERNAME
    $(error GH_USERNAME is undefined)
endif
	@curl -s $(GH_API)/repos/$(GH_USERNAME)/$(NAME) > $@

meta-release.json :
ifndef GH_USERNAME
    $(error GH_USERNAME is undefined)
endif
	@curl -s $(GH_API)/repos/$(GH_USERNAME)/$(NAME)/releases/latest > $@

meta-tarball-url : meta-release.json
	@jq -r .tarball_url < $< > $@

meta-release-tag-name : meta-release.json
	@jq -r .tag_name < $< > $@

meta-version : meta-release-tag-name
	@semver -l $$(cat $<) > $@

meta-description : meta-repo.json
	@jq -r .description < $< > $@

meta-vendor : meta-gh-user.json
	@if jq -r -e .name < $< > /dev/null; then \
	    printf '%s' "$$(jq -r .name < $<)" >> $@; \
	else \
	    printf '%s' "$$(jq -r .login)" >> $@; \
	fi
	@if jq -r -e .email < $< > /dev/null; then \
	    printf ' <%s>' "$$(jq -r .email < $<)" >> $@; \
	fi
	@printf '\n' >> $@

meta-url : meta-repo.json
	@jq -r .homepage < $< > $@

meta-license : release
	@case $$(licensecheck -mr $< | grep -v UNKNOWN | sort -u | wc -l) in \
	    0) echo "no licenses found!" 1>&2; exit 1 ;; \
	    *) printf '%s' \
	        "$$(licensecheck -mr $< | grep -v UNKNOWN | sort -u | cut -f 2)" \
	        | sed -z 's/\n/ and /g' > $@ ;; \
	esac

release.tar.gz : meta-tarball-url
	@wget --quiet -O $@ $$(cat $<)

release : release.tar.gz
	@mkdir $@ && tar -C release --strip-components 1 -xf $<

clean :
	@rm -rf -- ./meta-* ./release* ./$(NAME)*.deb
