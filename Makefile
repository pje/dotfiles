all: bins link-dotfiles run-config-scripts

$(HOME)/.ackrc: $(CURDIR)/.ackrc
	ln -sf $< $@

$(HOME)/.bash_login: $(CURDIR)/.bash_login
	ln -sf $< $@

$(HOME)/.bashrc: $(CURDIR)/.bashrc
	ln -sf $< $@

$(HOME)/.ctags: $(CURDIR)/.ctags
	ln -sf $< $@

$(HOME)/.ghci: $(CURDIR)/.ghci
	ln -sf $< $@

$(HOME)/.gitconfig: $(CURDIR)/.gitconfig
	ln -sf $< $@

$(HOME)/.gitignore: $(CURDIR)/.gitignore
	ln -sf $< $@

$(HOME)/.irbrc: $(CURDIR)/.irbrc
	ln -sf $< $@

$(HOME)/.lein: $(CURDIR)/.lein
	mkdir -p $<

$(HOME)/.lein/profiles.clj: $(CURDIR)/.lein/profiles.clj
	ln -sf $< $@

$(HOME)/.profile: $(CURDIR)/.profile
	ln -sf $< $@

$(HOME)/.slate: $(CURDIR)/.slate
	ln -sf $< $@

$(HOME)/.vimrc: $(CURDIR)/.vimrc
	ln -sf $< $@

$(HOME)/com.googlecode.iterm2.plist: $(CURDIR)/com.googlecode.iterm2.plist
	ln -sf $< $@

$(HOME)/.atom: $(CURDIR)/.atom
	mkdir -p $<

$(HOME)/.atom/config.cson: $(CURDIR)/.atom/config.cson
	ln -sf $< $@

$(HOME)/.atom/keymap.cson: $(CURDIR)/.atom/keymap.cson
	ln -sf $< $@

link-dotfiles: \
		$(HOME)/com.googlecode.iterm2.plist \
		$(HOME)/.ackrc \
		$(HOME)/.bash_login \
		$(HOME)/.bashrc \
		$(HOME)/.ctags \
		$(HOME)/.ghci \
		$(HOME)/.gitconfig \
		$(HOME)/.gitignore \
		$(HOME)/.irbrc\
		$(HOME)/.lein \
		$(HOME)/.lein/profiles.clj \
		$(HOME)/.profile \
		$(HOME)/.slate \
		$(HOME)/.vimrc \
		$(HOME)/.atom \
		$(HOME)/.atom/config.cson \
		$(HOME)/.atom/keymap.cson

$(HOME)/bin:
	mkdir -p $@

bins:
	brew install michaeldfallen/formula/git-radar

osx:
	./osx.sh

/usr/local/bin/atom:
	brew cask list | grep atom || brew cask install atom

atom-packages: /usr/local/bin/atom \
	$(HOME)/.atom/config.cson \
	$(HOME)/.atom/keymap.cson \
	$(HOME)/.atom/packages/atom-alignment \
	$(HOME)/.atom/packages/atom-ctags \
	$(HOME)/.atom/packages/atom-macros \
	$(HOME)/.atom/packages/atom-solarized-dark-ui \
	$(HOME)/.atom/packages/change-case \
	$(HOME)/.atom/packages/custom-title \
	$(HOME)/.atom/packages/expand-region \
	$(HOME)/.atom/packages/gruvbox \
	$(HOME)/.atom/packages/highlight-selected \
	$(HOME)/.atom/packages/language-arduino \
	$(HOME)/.atom/packages/language-clojure \
	$(HOME)/.atom/packages/language-docker \
	$(HOME)/.atom/packages/language-protobuf \
	$(HOME)/.atom/packages/language-scala \
	$(HOME)/.atom/packages/lines \
	$(HOME)/.atom/packages/pretty-json \
	$(HOME)/.atom/packages/proto-repl \
	$(HOME)/.atom/packages/sort-lines \
	$(HOME)/.atom/packages/xml-formatter

$(HOME)/.atom/packages/atom-alignment:
	apm install atom-alignment

$(HOME)/.atom/packages/atom-ctags:
	apm install atom-ctags

$(HOME)/.atom/packages/atom-macros:
	apm install atom-macros

$(HOME)/.atom/packages/atom-solarized-dark-ui:
	apm install atom-solarized-dark-ui

$(HOME)/.atom/packages/change-case:
	apm install change-case

$(HOME)/.atom/packages/custom-title:
	apm install custom-title

$(HOME)/.atom/packages/expand-region:
	apm install expand-region

$(HOME)/.atom/packages/gruvbox:
	apm install gruvbox

$(HOME)/.atom/packages/highlight-selected:
	apm install highlight-selected

$(HOME)/.atom/packages/language-arduino:
	apm install language-arduino

$(HOME)/.atom/packages/language-clojure:
	apm install language-clojure

$(HOME)/.atom/packages/language-docker:
	apm install language-docker

$(HOME)/.atom/packages/language-protobuf:
	apm install language-protobuf

$(HOME)/.atom/packages/language-scala:
	apm install language-scala

$(HOME)/.atom/packages/lines:
	apm install lines

$(HOME)/.atom/packages/pretty-json:
	apm install pretty-json

$(HOME)/.atom/packages/proto-repl:
	apm install proto-repl

$(HOME)/.atom/packages/sort-lines:
	apm install sort-lines

$(HOME)/.atom/packages/xml-formatter:
	apm install xml-formatter

VIM_BUNDLE_DIR=$(HOME)/.vim/bundle
THE_RUBY_BIN_THAT_VIM_WAS_COMPILED_WITH=/System/Library/Frameworks/Ruby.framework/Versions/Current/usr/bin/ruby

vim-bundles: \
	$(VIM_BUNDLE_DIR) \
	$(VIM_BUNDLE_DIR)/command-t \
	$(VIM_BUNDLE_DIR)/gruvbox \
	$(VIM_BUNDLE_DIR)/vim-clojure-static

$(VIM_BUNDLE_DIR):
	mkdir -p $@

$(VIM_BUNDLE_DIR)/command-t:
	git clone git://git.wincent.com/command-t.git $@
	cd $@/ruby/command-t && $(THE_RUBY_BIN_THAT_VIM_WAS_COMPILED_WITH) extconf.rb && make

$(VIM_BUNDLE_DIR)/gruvbox:
	git clone git@github.com:morhetz/gruvbox.git $@

$(VIM_BUNDLE_DIR)/vim-clojure-static:
	git clone git@github.com:guns/vim-clojure-static.git $@

run-config-scripts: osx vim-bundles

.PHONY: all atom-packages bins link-dotfiles osx run-config-scripts vim-bundles
.DEFAULT: all
