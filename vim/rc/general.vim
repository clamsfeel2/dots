syntax enable
filetype plugin indent on
let mapleader="\<Space>"
set rtp+=/opt/homebrew/opt/fzf
set runtimepath+=~/.config/vim
set viminfo+=n~/.config/vim/.viminfo
set viminfofile=~/.config/vim/.viminfo
set directory=~/.cache/vim/swap//
set encoding=utf-8
set nocompatible
set number relativenumber title ruler showmatch wrap linebreak smoothscroll
set display+=lastline
set mouse=a
set tabpagemax=50
set modeline
set background=
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
set autoindent
set shiftround
set textwidth=0
set matchpairs+=(:),{:},[:],<:>
set completeopt-=preview
set path+=** wildmenu
set timeoutlen=200 updatetime=100
set ttimeout ttimeoutlen=1 ttyfast
set backspace=indent,eol,start
set splitright
set fillchars=vert:│,fold:┈,diff:┈
set hidden
set hlsearch
set incsearch

let $ZSH_ENV = expand("$HOME/.config/zsh/alifn")

" Disable :Explore
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

" Cursor Shape Settings
let &t_SI = "\e[6 q"  " Insert Mode
let &t_SR = "\e[6 q"  " Replace Mode
let &t_EI = "\e[2 q"  " Normal Mode

colorscheme clamtheme
