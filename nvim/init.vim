" Enable syntax highlighting
syntax enable

" Enable filetype detection and plugins
filetype plugin indent on

" Set leader key
let mapleader="\<Space>"

" Adjust runtime paths for Neovim
set rtp+=/opt/homebrew/opt/fzf
set runtimepath+=~/.config/nvim
set viminfo+=n~/.local/share/nvim/viminfo
set viminfofile=~/.local/share/nvim/viminfo
set directory=~/.local/state/nvim/swap//

" General settings
set encoding=utf-8
set nocompatible
set backspace=indent,eol,start
set number relativenumber title ruler showmatch wrap linebreak smoothscroll
set display+=lastline
set mouse=a
set modeline
" set background=
set tabstop=4 shiftwidth=4 softtabstop=4 autoindent shiftround
set textwidth=0
set matchpairs+=(:),{:},[:],<:>
set completeopt-=preview
set path+=** wildmenu
set timeoutlen=200 updatetime=100

" Environment variables
let $ZSH_ENV = expand("$HOME/.config/zsh/alifn")

" Netrw settings
let g:netrw_banner = 0

" Cursor Shape Settings (Neovim handles this differently, but keeping for compatibility)
" let &t_SI = "\e[6 q"  " Insert Mode
" let &t_SR = "\e[2 q"  " Replace Mode
" let &t_EI = "\e[2 q"  " Normal Mode

for f in split(glob('$HOME/.config/nvim/config/*.vim'), '\n')
  execute 'source' f
endfor

" Colorscheme
colorscheme nord
