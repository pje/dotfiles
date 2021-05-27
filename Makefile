all: link-dotfiles system-packages node-packages vim-packages vscode-packages macos

UNAME_S := $(shell uname -s)

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

$(HOME)/.inputrc: $(CURDIR)/.inputrc
	ln -sf $< $@

$(HOME)/.irbrc: $(CURDIR)/.irbrc
	ln -sf $< $@

$(HOME)/.lein: $(CURDIR)/.lein
	mkdir -p $@

$(HOME)/.lein/profiles.clj: $(HOME)/.lein $(CURDIR)/.lein/profiles.clj
	ln -sf $< $@

$(HOME)/.profile: $(CURDIR)/.profile
	ln -sf $< $@

$(HOME)/.pryrc: $(CURDIR)/.pryrc
	ln -sf $< $@

$(HOME)/.slate: $(CURDIR)/.slate
	ln -sf $< $@

$(HOME)/.vimrc: $(CURDIR)/.vimrc
	ln -sf $< $@

$(HOME)/com.googlecode.iterm2.plist: $(CURDIR)/com.googlecode.iterm2.plist
	ln -sf $< $@

$(HOME)/.atom: $(CURDIR)/.atom
	mkdir -p $@

$(HOME)/.atom/config.cson: $(HOME)/.atom $(CURDIR)/.atom/config.cson
	ln -sf $< $@

$(HOME)/.atom/keymap.cson: $(HOME)/.atom $(CURDIR)/.atom/keymap.cson
	ln -sf $< $@

$(HOME)/.atom/styles.less: $(HOME)/.atom $(CURDIR)/.atom/styles.less
	ln -sf $< $@

$(HOME)/Library/Application\ Support/Code/User/settings.json: $(CURDIR)/vscode/settings.json
	mkdir -p $(HOME)/Library/Application\ Support/Code/User/
	ln -sf "$<" "$@"

$(HOME)/Library/Application\ Support/Code/User/keybindings.json: $(CURDIR)/vscode/keybindings.json
	mkdir -p $(HOME)/Library/Application\ Support/Code/User/
	ln -sf "$<" "$@"

link-dotfiles: \
	$(HOME)/com.googlecode.iterm2.plist \
	$(HOME)/.ackrc \
	$(HOME)/.bash_login \
	$(HOME)/.bashrc \
	$(HOME)/.ctags \
	$(HOME)/.ghci \
	$(HOME)/.gitconfig \
	$(HOME)/.gitignore \
	$(HOME)/.inputrc \
	$(HOME)/.irbrc\
	$(HOME)/.lein \
	$(HOME)/.lein/profiles.clj \
	$(HOME)/.profile \
	$(HOME)/.pryrc \
	$(HOME)/.slate \
	$(HOME)/.vimrc \
	$(HOME)/.atom \
	$(HOME)/.atom/config.cson \
	$(HOME)/.atom/keymap.cson \
	$(HOME)/.atom/styles.less \
	$(HOME)/Library/Application\ Support/Code/User/settings.json \
	$(HOME)/Library/Application\ Support/Code/User/keybindings.json

system-packages: $(HOME)/fzf rustup-init.sh yarn_install.sh $(ifeq $(UNAME_S Darwin),brew-packages,linux-packages)
	which fzf || ~/fzf/install --key-bindings --completion --no-update-rc
	which cargo || ./rustup-init.sh -y --no-modify-path
	which yarn || ./yarn_install.sh

brew-packages:
	which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew tap Homebrew/bundle
	brew bundle check || brew bundle

linux-packages:
	@echo "nothing"

$(HOME)/fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git $(HOME)/fzf

rustup-init.sh:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup-init.sh
	chmod +x rustup-init.sh

yarn_install.sh:
	curl -o- -L https://yarnpkg.com/install.sh > yarn_install.sh
	chmod +x yarn_install.sh

macos: $(HOME)/Library/Fonts/Consolas.ttf
	./macos.sh

$(HOME)/Library/Fonts/Consolas.ttf:
	curl https://raw.githubusercontent.com/pje/Consolas.ttf/master/Consolas.ttf --output $(HOME)/Library/Fonts/Consolas.ttf

node-packages:
	$(HOME)/.yarn/bin/yarn global add diff-so-fancy --prefix /usr/local

vscode-packages:
	$(HOME)/.yarn/bin/yarn add --dev prettier @prettier/plugin-ruby
	code --list-extensions | grep esbenp.prettier-vscode         || code --install-extension esbenp.prettier-vscode
	code --list-extensions | grep alexdima.copy-relative-path    || code --install-extension alexdima.copy-relative-path
	code --list-extensions | grep eg2.tslint                     || code --install-extension eg2.tslint
	code --list-extensions | grep karunamurti.haml               || code --install-extension karunamurti.haml
	code --list-extensions | grep kumar-harsh.graphql-for-vscode || code --install-extension kumar-harsh.graphql-for-vscode
	code --list-extensions | grep iocave.customize-ui            || code --install-extension iocave.customize-ui
	code --list-extensions | grep miguel-savignano.ruby-symbols  || code --install-extension miguel-savignano.ruby-symbols
	code --list-extensions | grep mikestead.dotenv               || code --install-extension mikestead.dotenv
	code --list-extensions | grep ms-vscode.atom-keybindings     || code --install-extension ms-vscode.atom-keybindings
	code --list-extensions | grep rebornix.ruby                  || code --install-extension rebornix.ruby
	code --list-extensions | grep tomphilbin.gruvbox-themes      || code --install-extension tomphilbin.gruvbox-themes
	code --list-extensions | grep wmaurer.change-case            || code --install-extension wmaurer.change-case

VIM_BUNDLE_DIR=$(HOME)/.vim/pack/default/start
THE_RUBY_BIN_THAT_VIM_WAS_COMPILED_WITH=/usr/local/opt/ruby/bin/ruby

vim-packages: \
	$(VIM_BUNDLE_DIR) \
	$(VIM_BUNDLE_DIR)/command-t \
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

.PHONY: all brew-packages link-dotfiles macos node-packages system-packages linux-packages vim-packages vscode-packages
.DEFAULT: all
