" ==============================
" Search Utility
" ==============================
" Display the search pattern and count matches
function! SearchAndCount()
    let search_pattern = @/
    execute ":%s/" . search_pattern . "//n"
    return search_pattern
endfunction

" ==============================
" Helpful
" ==============================
function! DeleteCurrentCell()
    " Get the current line and cursor column (0-indexed)
    let line = getline('.')
    let colpos = col('.') - 1

    " Find the last '|' before the cursor and the next '|' after
    let start = strridx(strpart(line, 0, colpos), '|')
    let end = stridx(line, '|', colpos)
    if start == -1 || end == -1
        echo "Not inside a table cell."
        return
    endif

    " Keep the pipes and remove text in between
    let newline = strpart(line, 0, start + 1) . strpart(line, end)
    call setline('.', newline)
endfunction

function! DeleteTrailingWS()
    let l:save = winsaveview()
    silent! keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

function! OpenKittyDoc()
    let l:line = getline('.')
    if l:line =~? '\vhttps?://'
        let l:url = matchstr(l:line, '\vhttps?://\S+')
    else
        let l:pat = (&filetype ==# 'kitty') ? '^\s*\zs\S\+' : '\vhttps?://\S+[^)]'
        let l:match = matchstr(l:line, l:pat)
        let l:url = (&filetype ==# 'kitty' && !empty(l:match)) ? "https://sw.kovidgoyal.net/kitty/conf/#opt-kitty." . l:match : l:match
    endif
    if empty(l:url)
        echo "No valid URL/option found on the current line."
    else
        call system('open ' . shellescape(l:url))
    endif
endfunction

" ==============================
" FZF Integration
" ==============================
function! FzfSpell() abort
    let word = expand("<cword>")
    let suggestions = spellsuggest(word)
    let style_on = nr2char(27) . "[1;4;3m"
    let reset = nr2char(27) . "[0m"
    " Prepend the bolded option to the suggestions list
    call insert(suggestions, style_on . "Add '" . word . "' to dictionary" . reset, 0)
    call fzf#run(fzf#wrap({
                \ 'source': suggestions,
                \ 'sink': {selected -> FzfSpellSink(selected, word)},
                \ 'options': '--ansi'
                \ }))
endfunction

function! FzfSpellSink(selected, origWord) abort
    " Strip ANSI escape codes before comparing
    let sel = substitute(a:selected, '\V' . nr2char(27) . '\[[0-9;]*m', '', 'g')
    if sel == "Add '" . a:origWord . "' to dictionary"
        execute 'normal! zg'
    else
        execute 'normal! "_ciw' . sel
    endif
endfunction

" ==============================
" Vimwiki Utility
" ==============================
" Insert a dropdown menu in Vimwiki
function! InsertDetails() abort
  let title = input("Dropdown title: ")
  let block = [
        \ "<details closed><summary>" . title . "</summary>",
        \ "",
        \ "</details>"
        \ ]
  " Insert block above the current line
  call append(line('.') - 1, block)
  " Position cursor on the block’s first line and enter insert mode at the end
  execute "normal! " . line('.') . "G0"
  startinsert
endfunction


function! InsertTime() abort
  let time = "@" . strftime("%H:%M")
  " If file is empty replace the first (empty) line with the time otherwise append the time as a new line at the end.
  if line('$') == 1 && getline(1) == ''
    call setline(1, time)
  else
    call append(line('$'), time)
  endif
  " Append an empty line and start insert mode.
  call append(line('$'), '')
  normal! G
  startinsert
endfunction

" ==============================
" Goyo Integration
" ==============================
" " Setup actions upon entering Goyo mode
" function! Goyo_Enter()
"   let b:quitting = 0
"   let b:quitting_bang = 0
"   autocmd QuitPre <buffer> let b:quitting = 1
"   cabbrev <buffer> q! let b:quitting_bang = 1 | q!
" endfunction

" " Handle actions upon leaving Goyo mode
" function! Goyo_Leave()
"   if (&ft == 'vimwiki' || &ft == 'markdown' || &ft == 'help') && b:quitting
"     if b:quitting_bang
"       qa!
"     else
"       qa
"     endif
"   endif
" endfunction

" Toggle Goyo mode
function! ToggleGoyo()
    if exists("g:goyo_running")
        execute "Goyo!"
        execute "colorscheme clamtheme"
    else
        execute "Goyo"
    endif
endfunction

" ==============================
" Vimwiki HTML Conversion
" ==============================
" Convert current Vimwiki file to HTML and remove style.css
function! RunHTMLVimWikiCmd()
    execute 'Vimwiki2HTML'
    call system('rm "$HOME/Documents/Mollusk/Documents/Notes/frontend/html/style.css"')
endfunction

" Convert all Vimwiki files to HTML and remove style.css
function! RunHTMLVimWikiAllCmd()
    execute 'VimwikiAll2HTML'
    call system('rm "$HOME/Documents/Mollusk/Documents/Notes/frontend/html/style.css"')
endfunction

" ==============================
" Coc
" ==============================
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
