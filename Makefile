all: link-dotfiles system-packages node-packages vim-packages vscode-packages macos

UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Darwin)
	VSCODE_SETTINGS_DIR=$(HOME)/Library/Application\ Support/Code/User
else
	VSCODE_SETTINGS_DIR=$(HOME)/.config/Code/User
endif

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

$(HOME)/.slate: $(CURDIR)/.slate
	ln -sf $< $@

$(HOME)/.vimrc: $(CURDIR)/.vimrc
	ln -sf $< $@

$(HOME)/com.googlecode.iterm2.plist: $(CURDIR)/com.googlecode.iterm2.plist
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
	$(HOME)/.hushlogin \
	$(HOME)/.inputrc \
	$(HOME)/.irbrc\
	$(HOME)/.lein \
	$(HOME)/.lein/profiles.clj \
	$(HOME)/.pryrc \
	$(HOME)/.slate \
	$(HOME)/.vimrc \
	$(VSCODE_SETTINGS_DIR)/keybindings.json \
	$(VSCODE_SETTINGS_DIR)/settings.json

system-packages: $(HOME)/fzf rustup-init.sh yarn_install.sh $(ifeq $(UNAME_S Darwin),brew-packages,linux-packages)
	which fzf || ~/fzf/install --key-bindings --completion --no-update-rc
	which cargo || ./rustup-init.sh -y --no-modify-path
	which yarn || ./yarn_install.sh

system-scripts: $(ifeq $(UNAME_S Darwin),macos,linux)

brew-packages:
	which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew tap Homebrew/bundle
	brew bundle check || brew bundle

linux-packages:
	@echo "nothing"

linux:
	@echo "nothing"

macos: $(HOME)/Library/Fonts/Consolas.ttf
	./macos.sh

$(HOME)/fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git $(HOME)/fzf

rustup-init.sh:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup-init.sh
	chmod +x rustup-init.sh

yarn_install.sh:
	curl -o- -L https://yarnpkg.com/install.sh > yarn_install.sh
	chmod +x yarn_install.sh

$(HOME)/Library/Fonts/Consolas.ttf:
	mkdir -p $(HOME)/Library/Fonts
	curl https://raw.githubusercontent.com/pje/Consolas.ttf/master/Consolas.ttf --output $(HOME)/Library/Fonts/Consolas.ttf

node-packages:
	$(HOME)/.yarn/bin/yarn global add diff-so-fancy prettier @prettier/plugin-ruby --prefix $(HOME) # this will put binaries in ~/bin/

vscode-packages: node-packages
	code --list-extensions | grep esbenp.prettier-vscode         || code --install-extension esbenp.prettier-vscode
	code --list-extensions | grep alexdima.copy-relative-path    || code --install-extension alexdima.copy-relative-path
	code --list-extensions | grep eg2.tslint                     || code --install-extension eg2.tslint
	code --list-extensions | grep karunamurti.haml               || code --install-extension karunamurti.haml
	code --list-extensions | grep kumar-harsh.graphql-for-vscode || code --install-extension kumar-harsh.graphql-for-vscode
	code --list-extensions | grep iocave.customize-ui            || code --install-extension iocave.customize-ui
	code --list-extensions | grep miguel-savignano.ruby-symbols  || code --install-extension miguel-savignano.ruby-symbols
	code --list-extensions | grep mikestead.dotenv               || code --install-extension mikestead.dotenv
	$(VIM_BUNDLE_DIR)/gruvbox \
	$(VIM_BUNDLE_DIR)/vim-clojure-static

$(VIM_BUNDLE_DIR):
	mkdir -p $@

$(VIM_BUNDLE_DIR)/command-t:
	git clone git://git.wincent.com/command-t.git $@
	cd $@/ruby/command-t && $(THE_RUBY_BIN_THAT_VIM_WAS_COMPILED_WITH) ext/command-t/extconf.rb && make
	cd $@ && rake make

$(VIM_BUNDLE_DIR)/gruvbox:
	git clone git@github.com:morhetz/gruvbox.git $@

$(VIM_BUNDLE_DIR)/vim-clojure-static:
	git clone git@github.com:guns/vim-clojure-static.git $@

.PHONY: all brew-packages link-dotfiles macos node-packages system-packages system-scripts linux linux-packages vim-packages vscode-packages
.DEFAULT: all
