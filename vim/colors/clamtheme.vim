let g:colors_name = "clamtheme"

" ==============================
" ==============================
" GENERAL THEMEING
" ==============================
" ==============================

" ==============================
" Cusor/Line
" ==============================
highlight CursorLineNr term=bold cterm=bold ctermfg=109 ctermbg=NONE
highlight LineNr ctermfg=gray guifg=#555555
highlight CursorLine ctermbg=NONE guibg=NONE gui=NONE cterm=NONE

" ==============================
" String Stuff
" ==============================
highlight String ctermfg=6
highlight todo ctermfg=220 cterm=bold ctermbg=NONE
highlight fix ctermfg=228 cterm=bold ctermbg=NONE
highlight WordUnderCursor ctermfg=yellow guifg=yellow
highlight CursorWord ctermfg=yellow

" ==============================
" Trailing Whitespace
" ==============================
highlight ExtraWhitespace ctermbg=red guibg=red
augroup ExtraWhitespaceHighlighting
  autocmd!
  autocmd InsertEnter * match none
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
augroup END


" ==============================
" Search
" ==============================
highlight IncSearch cterm=bold ctermfg=blue ctermbg=NONE
highlight Search cterm=bold ctermfg=blue ctermbg=NONE

" ==============================
" Spell Checking
" ==============================
" Highlight spelling errors
highlight clear SpellBad
highlight SpellBad cterm=underline ctermul=1 ctermfg=red
highlight clear SpellCap
highlight SpellCap cterm=underline ctermul=0 ctermfg=blue

" ==============================
" Tab Line and Folded Text
" ==============================
highlight TabLine ctermfg=Grey ctermbg=NONE cterm=NONE
highlight TabLineSel cterm=bold ctermfg=Green ctermbg=NONE
highlight TabLineFill term=bold cterm=bold
highlight Folded ctermbg=NONE ctermfg=white term=bold

" ==============================
" Splits
" ==============================
" Vertical split settings
highlight VertSplit cterm=NONE

" ==============================
" Visual Selection
" ==============================
highlight Visual ctermfg=black ctermbg=yellow

" ==============================
" ==============================
" PLUGIN SPECIFIC THEMEING
" ==============================
" ==============================

" ==============================
" Sneak
" ==============================
hi Sneak ctermfg=15 ctermbg=12
hi SneakScope ctermfg=15 ctermbg=12
hi SneakLabel ctermfg=15 ctermbg=12

" ==============================
" GitGutter
" ==============================
highlight SignColumn guibg=NONE ctermbg=NONE
highlight GitGutterAdd ctermfg=2 ctermbg=NONE
highlight GitGutterChange ctermfg=3 ctermbg=NONE
highlight GitGutterDelete ctermfg=1 ctermbg=NONE

" ==============================
" Vimwiki
" ==============================
hi VimwikiLink ctermfg=4
hi VimwikiTodo ctermfg=Yellow
syn match VimwikiTodo /\v(TODO|FIXME|NOTE)/ containedin=.*Comment

augroup VimwikiCustomHighlighting
    autocmd!
    autocmd FileType vimwiki,markdown call s:VimwikiHighlighting()
augroup END

function! s:VimwikiHighlighting()
    for i in range(1, 6)
        execute 'highlight VimwikiHeader' . i . ' ctermfg=' . [11, 173, 182, 2, 108, 109][i - 1]
        execute 'syntax match VimwikiHeader' . i . ' "^' . repeat('#', i) . ' .*"'
    endfor
    highlight VimwikiList ctermfg=189
    syntax match VimwikiList /^\s*[-+*]\s/
endfunction

" ==============================
" Coc
" ==============================
highlight CocInlayHint guifg=#666666 ctermfg=242
highlight Pmenu       ctermfg=221 ctermbg=236
highlight PmenuSel    ctermfg=16  ctermbg=173
highlight PmenuSbar   ctermbg=236
highlight PmenuThumb  ctermbg=221
highlight CocMenuSel  ctermfg=16  ctermbg=173
