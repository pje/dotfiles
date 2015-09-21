all: bins link-dotfiles run-config-scripts

$(HOME)/.ackrc: $(CURDIR)/.ackrc
	ln -sf $< $@

$(HOME)/.bash_login: $(CURDIR)/.bash_login
	ln -sf $< $@

$(HOME)/.bashrc: $(CURDIR)/.bashrc
	ln -sf $< $@

$(HOME)/.ghci: $(CURDIR)/.ghci
	ln -sf $< $@

$(HOME)/.gitconfig: $(CURDIR)/.gitconfig
	ln -sf $< $@

$(HOME)/.gitignore: $(CURDIR)/.gitignore
	ln -sf $< $@

$(HOME)/.irbrc: $(CURDIR)/.irbrc
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
		$(HOME)/.ghci \
		$(HOME)/.gitconfig \
		$(HOME)/.gitignore \
		$(HOME)/.irbrc\
		$(HOME)/.profile \
		$(HOME)/.slate \
		$(HOME)/.vimrc \
		$(HOME)/.atom \
		$(HOME)/.atom/config.cson \
		$(HOME)/.atom/keymap.cson

$(HOME)/bin:
	mkdir -p $@

$(HOME)/bin/vcprompt: $(HOME)/bin
	mkdir -p ~/bin
	curl -sL https://raw.githubusercontent.com/djl/vcprompt/v1.0.1/bin/vcprompt > ~/bin/vcprompt
	chmod 755 ~/bin/vcprompt

bins: $(HOME)/bin/vcprompt

osx:
	./osx.sh

atom:
	brew cask list | grep atom || brew cask install atom

atom-packages: \
	atom \
	$(HOME)/.atom/config.cson \
	$(HOME)/.atom/keymap.cson \
	$(HOME)/.atom/packages/atom-alignment \
	$(HOME)/.atom/packages/atom-ctags \
	$(HOME)/.atom/packages/atom-macros \
	$(HOME)/.atom/packages/atom-solarized-dark-ui \
	$(HOME)/.atom/packages/change-case \
	$(HOME)/.atom/packages/custom-title \
	$(HOME)/.atom/packages/gruvbox \
	$(HOME)/.atom/packages/highlight-selected \
	$(HOME)/.atom/packages/language-arduino \
	$(HOME)/.atom/packages/language-clojure \
	$(HOME)/.atom/packages/language-docker \
	$(HOME)/.atom/packages/language-lua \
	$(HOME)/.atom/packages/language-protobuf \
	$(HOME)/.atom/packages/language-scala \
	$(HOME)/.atom/packages/lines \
	$(HOME)/.atom/packages/nrepl \
	$(HOME)/.atom/packages/pretty-json \
	$(HOME)/.atom/packages/sort-lines

$(HOME)/.atom/packages/atom-alignment:
	apm install $<

$(HOME)/.atom/packages/atom-ctags:
	apm install $<

$(HOME)/.atom/packages/atom-macros:
	apm install $<

$(HOME)/.atom/packages/atom-solarized-dark-ui:
	apm install $<

$(HOME)/.atom/packages/change-case:
	apm install $<

$(HOME)/.atom/packages/custom-title:
	apm install $<

$(HOME)/.atom/packages/gruvbox:
	apm install $<

$(HOME)/.atom/packages/highlight-selected:
	apm install $<

$(HOME)/.atom/packages/language-arduino:
	apm install $<

$(HOME)/.atom/packages/language-clojure:
	apm install $<

$(HOME)/.atom/packages/language-docker:
	apm install $<

$(HOME)/.atom/packages/language-lua:
	apm install $<

$(HOME)/.atom/packages/language-protobuf:
	apm install $<

$(HOME)/.atom/packages/language-scala:
	apm install $<

$(HOME)/.atom/packages/lines:
	apm install $<

$(HOME)/.atom/packages/nrepl:
	apm install $<

$(HOME)/.atom/packages/pretty-json:
	apm install $<

$(HOME)/.atom/packages/sort-lines:
	apm install $<

VIM_BUNDLE_DIR=$(HOME)/.vim/bundle
THE_RUBY_BIN_THAT_VIM_WAS_COMPILED_WITH=/System/Library/Frameworks/Ruby.framework/Versions/Current/usr/bin/ruby

vim: $(VIM_BUNDLE_DIR) vim-bundles

vim-bundles: \
	$(VIM_BUNDLE_DIR)/command-t \
	$(VIM_BUNDLE_DIR)/vim-colors-solarized \
	$(VIM_BUNDLE_DIR)/gruvbox \
	$(VIM_BUNDLE_DIR)/vim-clojure-static

$(VIM_BUNDLE_DIR):
	mkdir -p $@

$(VIM_BUNDLE_DIR)/command-t:
	git clone git://git.wincent.com/command-t.git $@
	cd $@/ruby/command-t && $(THE_RUBY_BIN_THAT_VIM_WAS_COMPILED_WITH) extconf.rb && make

$(VIM_BUNDLE_DIR)/vim-colors-solarized:
	git clone git://github.com/altercation/vim-colors-solarized.git $@

$(VIM_BUNDLE_DIR)/gruvbox:
	git clone git@github.com:morhetz/gruvbox.git $@

$(VIM_BUNDLE_DIR)/vim-clojure-static:
	git clone git@github.com:guns/vim-clojure-static.git $@

run-config-scripts: osx vim

.PHONY: all atom atom-packages bins link-dotfiles osx run-config-scripts vim vim-bundles
.DEFAULT: all
