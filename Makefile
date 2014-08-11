DESTDIR ?= $(HOME)/Library/Application Support/Avian/Bundles
NAME ?= MoreThemes.tmbundle

all: bundle

clean:
	-rm -rf dist

FORCE:
fetch-%:
	git submodule update --recursive vendor/themes/$*

init-bundle:
	mkdir -p dist/$(NAME)/Themes
	cp src/info.plist dist/$(NAME)

bundle-base16: fetch-base16
	cp vendor/themes/base16/*.tmTheme dist/$(NAME)/Themes

bundle-daylerees: fetch-daylerees
	cp vendor/themes/daylerees/sublime/*.tmTheme dist/$(NAME)/Themes
	cp vendor/themes/daylerees/sublime/contrast/*.tmTheme dist/$(NAME)/Themes
	cp vendor/themes/daylerees/sublime/light/*.tmTheme dist/$(NAME)/Themes

bundle-vendor: bundle-base16 bundle-daylerees

bundle: init-bundle bundle-vendor

install: bundle
	mkdir -p "$(DESTDIR)"
	cp -pr dist/$(NAME) "$(DESTDIR)/$(NAME)"

uninstall:
	-rm -rf "$(DESTDIR)/$(NAME)"

.PHONY: all init-bundle bundle-src bundle-vendor bundle-base16 bundle-daylerees