""" MISC

" Handle Tab for bullet indentation
function! TabBullet()
	let line = getline('.')
	return "\<C-T>"
endfunction

" Handle Shift-Tab for bullet unindentation
function! ShiftTabBullet()
	let line = getline('.')
	return "\<C-D>"
endfunction

" Function to set nospell when entering a help buffer
function! SetNoSpell()
	if &filetype == "help"
		setlocal nospell
	endif
endfunction

" Allows me to press F11 to see how many occurences of searched word there are
function! SearchAndCount()
	let search_pattern = @/
	execute ":%s/" . search_pattern . "//n"
	return search_pattern
endfunction

""" FZF
function! FzfSpellSink(word)
	exe 'normal! "_ciw' . a:word
endfunction
function! FzfSpell()
	let suggestions = spellsuggest(expand("<cword>"))
	call fzf#run(fzf#wrap({
				\ 'source': suggestions,
				\ 'sink': function('FzfSpellSink')
				"\ 'down': 10
				\ }))
endfunction

""" VIMWIKI
" Helps insert a dropdown menu (mostly for vimwiki for github ish)
function! InsertDetails()
	let summary_content = input("Dropdown title: ")
	let details_tag = "<details closed><summary>" . summary_content . "</summary>\n"
	let details_tag .= "\n</details>"
	execute "normal i" . details_tag
	execute "normal O\<Esc>"
endfunction

" Help for todo vimwiki
function! InsertTodo()
	execute "normal G"
	execute "normal o"
	if line("$") == 3 && getline(3) == ""
		execute "normal o- [ ]  "
	else
		execute "normal a "		
	endif
	startinsert
endfunction

" Help for diary vimwiki
function! InsertTime()
	let time = "@" . strftime("%H:%M")
	if line("$") == 1 && getline(1) == ""
		execute "normal! i" . time
		execute "normal o"
	else
		execute "normal G"
		execute "normal o"
		execute "normal! o" . time
		execute "normal o"
	endif
	execute "normal o"
	startinsert
endfunction

" Help for todo lists
function! InsertWInCheckbox()
	let line = getline(".")
	" Check for empty checkbox [ ] or [X] and change to [w]
	if line =~ '^\s*-\s\[\s\]' || line =~ '^\s*-\s\[x\]'
		let new_line = substitute(line, '\[\s\]', '[w]', '')
		let new_line = substitute(new_line, '\[x\]', '[w]', '')
	" Check for checkbox [w] and change to [ ]
	elseif line =~ '^\s*-\s\[w\]'
		let new_line = substitute(line, '\[w\]', '[ ]', '')
	" Change any other content inside brackets to [w]
	elseif line =~ '^\s*-\s\[\S\]'
		let new_line = substitute(line, '\[\S\]', '[w]', '')
	endif
	call setline('.', new_line)
endfunction

" Makes sure goyo quits on :q even if open
function! Goyo_Enter()
	let b:quitting = 0
	let b:quitting_bang = 0
	autocmd QuitPre <buffer> let b:quitting = 1
	cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! Goyo_Leave()
	" Quit Vim if this is the only remaining buffer
	" if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
	if (&ft == 'vimwiki' || &ft == 'markdown' || &ft == 'help') && b:quitting
		if b:quitting_bang
			qa!
		else
			qa
		endif
	endif
endfunction

" Check if Goyo is currently active
function! ToggleGoyo()
	if exists("g:goyo_running")
		" If Goyo is running, execute :Goyo! to close it
		execute "Goyo!"
	else
		" If Goyo is not running, execute :Goyo to open it
		execute "Goyo"
	endif
endfunction

" Helper to make sure style.css gets removed cuz idk lol
function! RunHTMLVimWikiCmd()
	execute 'Vimwiki2HTML'
	call system('\rm "${HOME}/Documents/Mollusk/Documents/Notes/Html/style.css"')
endfunction

function! RunHTMLVimWikiAllCmd()
	execute 'VimwikiAll2HTML'
	call system('\rm "${HOME}/Documents/Mollusk/Documents/Notes/Html/style.css"')
endfunction
