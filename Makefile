PKGS != find . \
    -maxdepth 1 -mindepth 1 -type d \
    -not -name '.git' \
    -not -name '_lib' \
    -printf '%f\n'

all:
	@parallel -i $(MAKE) --no-print-directory -C {} deb -- $(PKGS)

clean:
	@parallel -i $(MAKE) --no-print-directory -C {} clean -- $(PKGS)
