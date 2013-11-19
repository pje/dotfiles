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

$(HOME)/.vimrc: $(CURDIR)/.vimrc
	ln -sf $< $@

$(HOME)/com.googlecode.iterm2.plist: $(CURDIR)/com.googlecode.iterm2.plist
	ln -sf $< $@

link-dotfiles: $(HOME)/.ackrc $(HOME)/.bash_login $(HOME)/.bashrc $(HOME)/.ghci $(HOME)/.gitconfig $(HOME)/.gitignore $(HOME)/.irbrc $(HOME)/.profile $(HOME)/.vimrc $(HOME)/com.googlecode.iterm2.plist

osx:
	./osx.sh

run-config-scripts: osx

.PHONY: all link-dotfiles osx run-config-scripts
.DEFAULT: all
