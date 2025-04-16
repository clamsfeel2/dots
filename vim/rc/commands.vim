" ==============================
" Custom Commands
" ==============================
" Reload vimrc
command! SVR source $MYVIMRC
" Run HTML Vimwiki command
command! HTML call RunHTMLVimWikiCmd()
" Run HTML Vimwiki for all
command! HTMLALL call RunHTMLVimWikiAllCmd()
" Generate Vimwiki Table of Contents
command! TOC VimwikiTOC
" Open help in a new tab with Goyo
command! -nargs=+ H tab help <args> | Goyo
" Delete trailing whitespae
command! DeleteTrailingWS call DeleteTrailingWS()
" Quit files easier
command! Q :q!
command! Qa :qa!
command! QA :qa!
cnoreabbrev x wq

" Autocommands
augroup auto_commands
    autocmd!
    " ==============================
    " GENERAL SETTINGS
    " ==============================
    " Ensure viminfo settings are respected
    autocmd VimEnter * set viminfo+=n~/.vim/.viminfo
    " Start with insert mode and reset cursor to normal mode
    autocmd VimEnter,ShellCmdPost * startinsert | call feedkeys("\<Esc>")
    " Open :Files when opening a directory
    autocmd VimEnter * if isdirectory(expand('%')) | call timer_start(50, {-> execute('Files ' . expand('%'))}) | endif

    " ==============================
    " Relative Numbering
    " ==============================
    " Toggle relative number and cursorline based on focus
    autocmd FocusLost * set nocursorline norelativenumber
    autocmd FocusGained * set cursorline relativenumber

    " ==============================
    " FileTypeish Specific Settings
    " ==============================
    " Set textwidth to 0 for Vim files
    autocmd FileType vim set textwidth=0
    " Enable spell checking for specific file types
    autocmd BufNewFile,BufRead *.txt,*.md,*.tex set spell
    " Use leader + enter to clear search in vimwiki files and just enter in others
    autocmd FileType * if &filetype ==# 'vimwiki' | nnoremap <CR> <leader><CR> | else | nnoremap <CR> :nohlsearch<CR> | endif
    " Delete all trailing whitespace on save
    autocmd BufWritePre * if !&binary && &filetype != 'vimwiki' | call DeleteTrailingWS() | endif

    " ==============================
    " Syntax Highlighting and Conceal
    " ==============================
    " Highlight word under cursor for specific file types
    " autocmd FileType zsh,bash,sh,cpp,c,python,javascript,go,rust,swift,vim,gitignore,kitty,lua,conf*,html,css
    " 			\ autocmd CursorMoved * execute printf('match WordUnderCursor /\V\<%s\>/', escape(expand('<cword>'), '/\'))
    " Set conceal color for markdown files
    autocmd BufEnter,BufRead *.md highlight Conceal ctermbg=NONE ctermfg=5
    " Associate 'alifn' files with zsh filetype
    autocmd BufRead,BufNewFile alifn set filetype=zsh

    " ==============================
    " PLUGIN SETTINGS
    " ==============================
    " ------------------------------
    " ==============================
    " Vimwiki Settings
    " ==============================
    " Conceal HTML tags for dropdown menus in Vimwiki
    autocmd BufEnter,BufRead *.md if &filetype ==# 'vimwiki' |
                \ syn match CustomConceal "<details closed><summary>" conceal |
                \ syn match CustomConceal "</summary>" conceal |
                \ syn match CustomConceal "</details>\n" conceal cchar=. |
                \ endif
    " Auto-convert Vimwiki files to HTML on save
    autocmd FileType vimwiki autocmd BufWritePost silent! call RunHTMLVimWikiCmd()
    " Display &nbsp; as a space in Vimwiki
    autocmd BufEnter,BufRead *.md if &filetype ==# 'vimwiki' |
                \ syn match CustomConceal "&nbsp;" conceal cchar= |
                \ endif

    " ==============================
    " CoC
    " ==============================
    inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"

    " ==============================
    " CursorWord
    " ==============================
    " Make sure cursorword isn't highlighted in insert mode
    autocmd InsertEnter * let b:cursorword = 0
    autocmd InsertLeave * let b:cursorword = 1

    " ==============================
    " Color Scheme
    " ==============================
    " Set color scheme on Vim enter
    autocmd VimEnter * colorscheme clamtheme
augroup END
