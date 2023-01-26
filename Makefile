SHELL := /usr/bin/env bash

ifeq ($(shell uname -s), Darwin)
	MAC=true
	VSCODE_SETTINGS_DIR=$(HOME)/Library/Application\ Support/Code/User
else
	VSCODE_SETTINGS_DIR=$(HOME)/.config/Code/User
endif

all: \
		link-dotfiles \
		system-packages \
		vim-packages \
		$(if $(MAC),vscode-packages) \
		system-scripts

$(HOME)/.ackrc: $(CURDIR)/.ackrc
	ln -sf $< $@

$(HOME)/.bash_profile: $(CURDIR)/.bash_profile
	ln -sf $< $@

$(HOME)/.ctags: $(CURDIR)/.ctags
	ln -sf $< $@

$(HOME)/.ghci: $(CURDIR)/.ghci
	ln -sf $< $@

$(HOME)/.gitconfig: $(CURDIR)/.gitconfig
	ln -sf $< $@

$(HOME)/.gitignore: $(CURDIR)/.gitignore
	ln -sf $< $@

$(HOME)/.hammerspoon: $(CURDIR)/.hammerspoon
	ln -sf $< $@

$(HOME)/.hushlogin: $(CURDIR)/.hushlogin
	ln -sf $< $@

$(HOME)/.inputrc: $(CURDIR)/.inputrc
	ln -sf $< $@

$(HOME)/.irbrc: $(CURDIR)/.irbrc
	ln -sf $< $@

$(HOME)/.lein: $(CURDIR)/.lein
	mkdir -p $@

$(HOME)/.lein/profiles.clj: $(HOME)/.lein $(CURDIR)/.lein/profiles.clj
	ln -sf $< $@

$(HOME)/.pryrc: $(CURDIR)/.pryrc
	ln -sf $< $@

$(HOME)/.usergitconfig: $(CURDIR)/.usergitconfig
	ln -sf $< $@

$(HOME)/.vimrc: $(CURDIR)/.vimrc
	ln -sf $< $@

$(HOME)/com.googlecode.iterm2.plist: $(CURDIR)/com.googlecode.iterm2.plist
	ln -sf $< $@

$(HOME)/git_status_prompt.sh: $(CURDIR)/git_status_prompt.sh
	ln -sf $< $@

$(VSCODE_SETTINGS_DIR)/keybindings.json: $(CURDIR)/vscode/keybindings.json
	mkdir -p $(VSCODE_SETTINGS_DIR)
	ln -sf "$<" "$@"

$(VSCODE_SETTINGS_DIR)/settings.json: $(CURDIR)/vscode/settings.json
	mkdir -p $(VSCODE_SETTINGS_DIR)
	ln -sf "$<" "$@"

link-dotfiles: \
		$(HOME)/com.googlecode.iterm2.plist \
		$(HOME)/.ackrc \
		$(HOME)/.bash_profile \
		$(HOME)/.ctags \
		$(HOME)/.ghci \
		$(HOME)/.gitconfig \
		$(HOME)/.gitignore \
		$(HOME)/.hammerspoon \
		$(HOME)/.hushlogin \
		$(HOME)/.inputrc \
		$(HOME)/.irbrc\
		$(HOME)/.lein \
		$(HOME)/.lein/profiles.clj \
		$(HOME)/.pryrc \
		$(if $(MAC),$(HOME)/.usergitconfig) \
		$(HOME)/.vimrc \
		$(HOME)/git_status_prompt.sh \
		$(VSCODE_SETTINGS_DIR)/keybindings.json \
		$(VSCODE_SETTINGS_DIR)/settings.json

system-packages: \
		$(HOME)/fzf \
		$(HOME)/gitstatus \
		$(if $(MAC),mac-packages,linux-packages)
	which fzf || ~/fzf/install --key-bindings --completion --no-update-rc

linux-packages:
	wget https://github.com/dandavison/delta/releases/download/0.15.1/git-delta-musl_0.15.1_amd64.deb && sudo dpkg -i git-delta-musl_0.15.1_amd64.deb
	sudo apt-get install --yes \
		ack \
		bat \
		fd-find \
		fzf \
		htop \
		httpie \
		jq \
		parallel \
		pdsh \
		ripgrep \
		tmux \
		tree \
		vim \
		yarn

iterm-scripts: $(HOME)/Library/ApplicationSupport/iTerm2/Scripts/AutoLaunch/auto_switch_theme.py

$(HOME)/Library/ApplicationSupport/iTerm2/Scripts/AutoLaunch/auto_switch_theme.py: $(HOME)/Library/ApplicationSupport/iTerm2/Scripts/AutoLaunch

$(HOME)/Library/ApplicationSupport/iTerm2/Scripts/AutoLaunch:
	mkdir -p $@

homebrew:
	which brew || NONINTERACTIVE=1 /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew-packages: homebrew
	brew bundle check --file=Brewfile || brew bundle --file=Brewfile

system-scripts: $(if $(MAC),macos,linux)

linux:
	@echo "noop"

macos: $(HOME)/Library/Fonts/Consolas.ttf $(HOME)/.usergitconfig
	./macos.sh

$(HOME)/fzf:
	git clone --depth 1 https://github.com/junegunn/fzf $(HOME)/fzf

$(HOME)/gitstatus:
	git clone --depth=1 https://github.com/romkatv/gitstatus.git $(HOME)/gitstatus

$(HOME)/Library/Fonts/Consolas.ttf:
	mkdir -p $(HOME)/Library/Fonts
	curl https://raw.githubusercontent.com/pje/Consolas.ttf/master/Consolas.ttf --output $(HOME)/Library/Fonts/Consolas.ttf

vscode-packages:
	code --list-extensions | grep esbenp.prettier-vscode         || code --install-extension esbenp.prettier-vscode
	code --list-extensions | grep alexdima.copy-relative-path    || code --install-extension alexdima.copy-relative-path
	code --list-extensions | grep eg2.tslint                     || code --install-extension eg2.tslint
	code --list-extensions | grep karunamurti.haml               || code --install-extension karunamurti.haml
	code --list-extensions | grep kumar-harsh.graphql-for-vscode || code --install-extension kumar-harsh.graphql-for-vscode
	code --list-extensions | grep iocave.customize-ui            || code --install-extension iocave.customize-ui
	code --list-extensions | grep miguel-savignano.ruby-symbols  || code --install-extension miguel-savignano.ruby-symbols
	code --list-extensions | grep mikestead.dotenv               || code --install-extension mikestead.dotenv

VIM_BUNDLE_DIR=$(HOME)/.vim/pack/default/start

vim-packages:	\
		$(VIM_BUNDLE_DIR) \
		$(VIM_BUNDLE_DIR)/fzf \
		$(VIM_BUNDLE_DIR)/fzf.vim \
		$(VIM_BUNDLE_DIR)/gruvbox \
		$(VIM_BUNDLE_DIR)/vim-clojure-static

$(VIM_BUNDLE_DIR):
	mkdir -p $@

$(VIM_BUNDLE_DIR)/fzf: $(VIM_BUNDLE_DIR)
	if [ ! -d "$@" ]; then git clone https://github.com/junegunn/fzf $@; fi

$(VIM_BUNDLE_DIR)/fzf.vim: $(VIM_BUNDLE_DIR)
	if [ ! -d "$@" ]; then git clone https://github.com/junegunn/fzf.vim $@; fi

$(VIM_BUNDLE_DIR)/gruvbox: $(VIM_BUNDLE_DIR)
	if [ ! -d "$@" ]; then git clone https://github.com/morhetz/gruvbox $@; fi

$(VIM_BUNDLE_DIR)/vim-clojure-static: $(VIM_BUNDLE_DIR)
	if [ ! -d "$@" ]; then git clone https://github.com/guns/vim-clojure-static $@; fi

.PHONY: \
		all \
		brew-pack \
		brew-macos-packages \
		homebrew \
		iterm-scripts \
		link-dotfiles \
		linux \
		linux-packages \
		mac-packages \
		macos \
		system-packages \
		system-scripts \
		vim-packages \
		vscode-packages

.DEFAULT: all
