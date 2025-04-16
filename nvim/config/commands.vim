""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COMMANDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! SVR source $MYVIMRC
command! HTML :call RunHTMLVimWikiCmd()
command! HTMLALL :call RunHTMLVimWikiAllCmd()
command! TOC :VimwikiTOC
command! -nargs=+ H tab h <args> | Goyo

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTO COMMANDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup auto_commands
	autocmd!
	""" TODO -- This was the only way I could get vim to respect viminfo settings
	autocmd VimEnter * set viminfo+=n~/.local/share/nvim/viminfo
	""" CURSOR STARTING AS BLOCK
	autocmd VimEnter * startinsert | call feedkeys("\<Esc>")
	autocmd ShellCmdPost * startinsert | call feedkeys("\<Esc>")
	""" RELATIVE NUMBER
	" Turn off relative number when unfocused
	autocmd FocusLost * set nocursorline colorcolumn=0 norelativenumber
	autocmd FocusGained * set cursorline colorcolumn=+0 relativenumber
	""" COLORS
	" autocmd ColorScheme * call ClamColorscheme() | call VimWikiMarkdownHighlighting()
	""" TEXT WIDTH
	autocmd FileType vim set textwidth=0
	""" SPELLING
	autocmd BufEnter *.txt,*.md,*.tex call SetNoSpell()
	autocmd BufNewFile,BufRead *.txt,*.md,*.tex setlocal spell
	""" COLORING AND HIGHLIGHTING
	" To color all occurences of word under cursor
	autocmd FileType zsh,bash,sh,cpp,c,python,javascript,go,rust,swift,vim,gitignore,kitty,lua,conf*,html autocmd CursorMoved * execute printf('match WordUnderCursor /\V\<%s\>/', escape(expand('<cword>'), '/\\'))
	" Changing conceal cchar color -- 5 is purple
	autocmd BufEnter,BufRead *.md highlight Conceal ctermbg=NONE ctermfg=5
	" So .alifn will have syntax highlighting
	autocmd BufRead,BufNewFile alifn set filetype=zsh
	""" VIMWIKI
    " autocmd FileType vimwiki call VimWikiMarkdownHighlighting()
	" Be able to indent and unindent bullet points with tab/shift+tab markdown
	autocmd FileType vimwiki inoremap <buffer> <Tab> <C-R>=TabBullet()<CR>
	autocmd FileType vimwiki inoremap <buffer> <S-Tab> <C-R>=ShiftTabBullet()<CR>
	" This conceals the html tags for the dropdown menus... kinda hacky, but whatever
	" Change cchar to change character shown
	" &filetype returns type of file -- ==# does case sensitive match
	autocmd BufEnter,BufRead *.md if &filetype ==# 'vimwiki' 
				\ | syn match CustomConceal "<details closed><summary>" conceal
				\ | syn match CustomConceal "</summary>" conceal
				\ | syn match CustomConceal "</details>\n" conceal cchar=.
				\ | endif
	" Automatically converts files to HTML on save
	autocmd FileType vimwiki autocmd BufWritePost <buffer> silent! call RunHTMLVimWikiCmd()
	" Makes tab put in &nbsp; in vimwiki or markdown files
	" autocmd FileType markdown,vimwiki inoremap <buffer> <Tab> &nbsp;
	" Makes &nbsp; just show up as a space in vim
	autocmd BufEnter,BufRead *.md if &filetype ==# 'vimwiki' | syn match CustomConceal "&nbsp;" conceal cchar= | endif
	""" GOYO
	autocmd! User GoyoEnter call Goyo_Enter()
	autocmd! User GoyoLeave call Goyo_Leave() | colorscheme clamtheme

	" Color Scheme
	autocmd VimEnter * colorscheme clamtheme
augroup END
