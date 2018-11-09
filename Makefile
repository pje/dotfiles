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

$(HOME)/Library/Application\ Support/Code/User/settings.json: $(CURDIR)/settings.json
	ln -sf "$<" "$@"

$(HOME)/Library/Application\ Support/Code/User/keybindings.json: $(CURDIR)/keybindings.json
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
		$(HOME)/.slate \
		$(HOME)/.vimrc \
		$(HOME)/.atom \
		$(HOME)/.atom/config.cson \
		$(HOME)/.atom/keymap.cson \
		$(HOME)/.atom/styles.less \
		$(HOME)/Library/Application\ Support/Code/User/settings.json \
		$(HOME)/Library/Application\ Support/Code/User/keybindings.json

$(HOME)/bin:
	mkdir -p $@

bins:
	brew install michaeldfallen/formula/git-radar

osx:
	./osx.sh

/usr/local/bin/atom:
	brew cask install atom

/usr/local/bin/diff-so-fancy:
	npm install -g diff-so-fancy

atom-packages: /usr/local/bin/atom
	apm install                \
		atom-alignment           \
		atom-beautify            \
		atom-ctags               \
		atom-macros              \
		atom-solarized-dark-ui   \
		change-case              \
		copy-path                \
		custom-title             \
		expand-region            \
		gruvbox                  \
		highlight-selected       \
		increment-selection      \
		language-arduino         \
		language-bnf             \
		language-docker          \
		language-haskell         \
		language-javascript-jsx  \
		language-protobuf        \
		language-rust            \
		language-scala           \
		lines                    \
		linter                   \
		linter-eslint            \
		lisp-paredit             \
		pretty-json              \
		proto-repl               \
		sequential-number        \
		sort-lines               \
		xml-formatter

vscode-bundles:
	code --install-extension eg2.tslint
	code --install-extension esbenp.prettier-vscode
	code --install-extension lehni.vscode-titlebar-less-macos
	code --install-extension ms-vscode.atom-keybindings
	code --install-extension rebornix.ruby
	code --install-extension tomphilbin.gruvbox-themes

VIM_BUNDLE_DIR=$(HOME)/.vim/pack/default/start
THE_RUBY_BIN_THAT_VIM_WAS_COMPILED_WITH=/usr/local/opt/ruby/bin/ruby

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
