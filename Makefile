all: link-dotfiles run-config-scripts

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

link-dotfiles: $(HOME)/.ackrc $(HOME)/.bash_login $(HOME)/.bashrc $(HOME)/.ghci $(HOME)/.gitconfig $(HOME)/.gitignore $(HOME)/.irbrc $(HOME)/.profile $(HOME)/.slate $(HOME)/.vimrc $(HOME)/com.googlecode.iterm2.plist

osx:
	./osx.sh

VIM_BUNDLE_DIR=$(HOME)/.vim/bundle
THE_RUBY_BIN_THAT_VIM_WAS_COMPILED_WITH=/System/Library/Frameworks/Ruby.framework/Versions/Current/usr/bin/ruby

vim: $(VIM_BUNDLE_DIR) vim_bundles

vim_bundles: $(VIM_BUNDLE_DIR)/command-t $(VIM_BUNDLE_DIR)/vim-colors-solarized

$(VIM_BUNDLE_DIR):
	mkdir -p $@

$(VIM_BUNDLE_DIR)/command-t:
	git clone git://git.wincent.com/command-t.git $@
	cd $@/ruby/command-t && $(THE_RUBY_BIN_THAT_VIM_WAS_COMPILED_WITH) extconf.rb && make

$(VIM_BUNDLE_DIR)/vim-colors-solarized:
	git clone git://github.com/altercation/vim-colors-solarized.git $@

run-config-scripts: osx vim

.PHONY: all link-dotfiles osx run-config-scripts vim vim_bundles
.DEFAULT: all
