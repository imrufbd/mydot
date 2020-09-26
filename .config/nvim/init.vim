let mapleader =","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))


Plug 'vim-airline/vim-airline'					" Airline
Plug 'vim-airline/vim-airline-themes'				" Airline Themes
Plug 'chrisbra/unicode.vim'                       " unicode search
Plug 'chrisbra/Colorizer'                         " color from rgb
Plug 'flazz/vim-colorschemes'                     " vim colorscheme
Plug 'vimwiki/vimwiki'                            " vimwiki
Plug 'mcchrish/nnn.vim'                           " nnn file picker

call plug#end()


"execute pathogen#infect()
filetype plugin indent on    " required

set nocompatible              " be iMproved, required
filetype off                  " required

"Remap ESC to jj 
:imap jj <Esc>

"Disable arrow keys in Normal mode
no <Up> <Nop>
no <Down> <Nop>
no <Left> <Nop>
no <Right> <Nop>

"Disable arrow keys in Insert mode
ino <Up> <Nop>
ino <Down> <Nop>
ino <Left> <Nop>
ino <Right> <Nop>

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

"Copy paste Clipboard Access:

vnoremap <C-c> "+y
map <C-p> "+P


" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>s :setlocal spell! spelllang=en_us<CR>

syntax on   

set rtp+=/usr/share/powerline/bindings/vim/
set laststatus=2
set t_Co=256
set encoding=utf-8
set relativenumber
set number
set showcmd
set noshowmode
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set hlsearch

set splitbelow splitright

let g:rehash256 = 1
let g:Powerline_symbols='unicode'
let g:Powerline_theme='long'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized_flood'

" colorscheme solarized8_dark


map <C-n> :Np<CR>

hi LineNr ctermfg=242
hi CursorLineNr ctermfg=15
hi VertSplit ctermfg=8 ctermbg=0
hi Statement ctermfg=3


set path+=**					" Searches current directory recursively.
set wildmenu					" Display all matches when tab complete.
set incsearch
set nobackup
set noswapfile

let g:python_highlight_all = 1
syntax on

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

map <leader>h :ColorHighlight
noremap <leader>u :w \| startinsert \| term urlview %<cr>
":nnoremap <leader>u :silent w\|!urlview %<CR>

":vimwiki ext
let g:vimwiki_list = [{'path': '~/vimwiki/',
                       \ 'syntax': 'markdown', 'ext': '.md'}]