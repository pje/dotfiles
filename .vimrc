" Leaders are needed before plugins are loaded
let mapleader=","
let g:mapleader=","
let maplocalleader=","
let g:maplocalleader=","

set nocompatible

call pathogen#infect()

" Text Handling
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set backspace=2
set autoindent
set smartindent
set smarttab
set nowrap
set nofoldenable
set sidescroll=5
set grepprg=ack\ -a\ -G\ '[^.6]$'

"set list             " alternate: set listchars+=tab:▸\ ,eol¬
"set listchars=tab:»· 
"set listchars+=trail:·
"set listchars+=precedes:<,extends:>

:set et sw=2 ts=2 sts=2
:highlight ExtraWhitespace ctermfg=15 ctermbg=4 guifg=#CF6A4C guibg=#420E09
:match ExtraWhitespace /\s\+$\| \+\ze\t/

if has("gui_macvim")
  let macvim_skip_cmd_opt_movement = 1
  set guioptions=egmt
  set antialias
  set fuoptions=maxvert,maxhorz
endif

" Look and Feel
set number
set hlsearch
set incsearch
set ignorecase
set smartcase
set wildmenu
set wildmode=list,full
set ruler
set modeline
set modelines=5
set laststatus=1      " show only with more than window
set mouse=v
set showcmd
set showmatch
set visualbell
set winminheight=0
set statusline=%F\ %m%r%w%y\ %=(%L\ loc)\ [#\%03.3b\ 0x\%02.2B]\ \ %l,%v\ \ %P

" Files/Paths/Buffers
set hidden
set autowriteall
set autoread          " reload when no local changes
set backup
set backupdir=~/.vim/backup,~/.backup,~/tmp,/var/tmp/,/tmp,.
set directory=~/tmp,/var/tmp,/tmp,.

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.6,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.class,.jar

" Per file-type indentation
autocmd BufEnter *.js  set sts=4 sw=4
autocmd BufEnter *.c   set sts=4 sw=4
autocmd BufEnter *.go  set ts=2 sw=2 noet nolist ai

" File-type
filetype on
filetype plugin on
filetype indent on

" Colors
" if $TERM == "rxvt-unicode"
"   set t_Co=256
" endif

fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

autocmd BufWritePre *.h :call <SID>StripTrailingWhitespaces()

colorscheme solarized
set background=light

syntax enable

nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>a :Ack


"" Bash out extra whitespace
highlight StatusLine ctermbg=234
highlight StatusLineNC ctermbg=232 ctermfg=8
highlight Pmenu ctermfg=black ctermbg=brown gui=bold
highlight PmenuSel ctermfg=black ctermbg=lightmagenta gui=bold
highlight LineNr ctermbg=NONE

" indent-guides
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 0

"" Mappings
map <Leader>n :nohlsearch<CR>
map <Leader>p :set paste<CR>
map <Leader>P :set nopaste<CR>

