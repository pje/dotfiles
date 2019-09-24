all: brew-packages link-dotfiles node-packages vim-packages vscode-packages macos

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
	mkdir -p $<

$(HOME)/.lein/profiles.clj: $(CURDIR)/.lein/profiles.clj
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
	mkdir -p $<

$(HOME)/.atom/config.cson: $(CURDIR)/.atom/config.cson
	ln -sf $< $@

$(HOME)/.atom/keymap.cson: $(CURDIR)/.atom/keymap.cson
	ln -sf $< $@

$(HOME)/.atom/styles.less: $(CURDIR)/.atom/styles.less
	ln -sf $< $@

$(HOME)/Library/Application\ Support/Code/User/settings.json: $(CURDIR)/vscode/settings.json
	ln -sf "$<" "$@"

$(HOME)/Library/Application\ Support/Code/User/keybindings.json: $(CURDIR)/vscode/keybindings.json
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

brew-packages:
	which brew || ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
	brew tap Homebrew/bundle
	brew bundle check || brew bundle

macos:
	./macos.sh

node-packages:
	yarn global add diff-so-fancy --prefix /usr/local

vscode-packages:
	code --install-extension alexdima.copy-relative-path
	code --install-extension eg2.tslint
	code --install-extension esbenp.prettier-vscode
	code --install-extension karunamurti.haml
	code --install-extension kumar-harsh.graphql-for-vscode
	code --install-extension lehni.vscode-titlebar-less-macos
	code --install-extension miguel-savignano.ruby-symbols
	code --install-extension mikestead.dotenv
	code --install-extension ms-vscode.atom-keybindings
	code --install-extension rebornix.ruby
	code --install-extension tomphilbin.gruvbox-themes
	code --install-extension wmaurer.change-case
	code --install-extension wwm.better-align

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

.PHONY: all brew-packages link-dotfiles macos node-packages vim-packages vscode-packages
.DEFAULT: all
