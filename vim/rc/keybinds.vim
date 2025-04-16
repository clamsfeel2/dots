" ==============================
" GENERAL KEY BINDINGS
" ==============================

" Escape and Editing Shortcuts
inoremap <C-c> <Nop>  " Prevent Ctrl+C from being used as an alternative to Esc
nnoremap <C-c> <Nop>

" Search and Highlight Management
nnoremap <C-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
" nnoremap <leader><CR> :nohlsearch<CR>
nnoremap <F10> :let @/ = SearchAndCount()<CR>

" Navigation and Window Management
nnoremap <leader>a <C-w>
nnoremap <leader>v :Commands<CR>
nnoremap <leader>c :!zsh -i -c "gpc commit"<CR>

" Tab Navigation
nnoremap <leader>l gt
nnoremap <leader>h gT
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

" Cursor Movements
noremap <C-j> gj
noremap <C-k> gk
nnoremap <expr> j v:count ? (v:count > 0 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 0 ? "m'" . v:count : '') . 'k' : 'gk'

" Text Manipulation
" nnoremap S :%s//g<Left><Left>
nnoremap <C-d> yyp
nnoremap <C-p> yy:Commentary<CR>p
nnoremap dae :%!pbpaste<CR>

" Delete current cell in markdown table
nnoremap dic :call DeleteCurrentCell()<CR>

" Visual Mappings
nnoremap vv <Esc><Esc><C-V>
xnoremap <C-c> y:call system("pbcopy", @")<CR>  " Copy to clipboard in visual mode
xnoremap <CR> <Esc>

" Kitty Search
nnoremap <leader>o :call OpenKittyDoc()<CR>

" ==============================
" PLUGIN KEY BINDINGS
" ==============================

" Vimwiki
nnoremap <leader>wi :VimwikiDiaryIndex 1<CR>
nnoremap <leader>n :VimwikiMakeDiaryNote 1<CR>:call InsertTime()<CR>
nnoremap <leader>i :VimwikiIncrementListItem<CR>
nnoremap <leader>d :VimwikiDecrementListItem<CR>

" Commentary
nnoremap gcc :Commentary<CR>
vnoremap gc :Commentary<CR>
nnoremap co :Commentary<CR>
vnoremap co :Commentary<CR>

" VimSneak
map f <Plug>Sneak_s
map F <Plug>Sneak_S

" YouCompleteMe
" map <F12> <plug>(YCMHover)
" nnoremap <silent> <F9> :execute "YcmCompleter RefactorRename" input("Rename to: ")<CR>
" CoC
inoremap <silent><expr> <C-@> coc#refresh()
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nnoremap <silent> K :call ShowDocumentation()<CR>
nnoremap <silent> F12 :call ShowDocumentation()<CR>
nmap F9 <Plug>(coc-rename)
" inoremap <expr> <Space> pumvisible() ? "\<C-y>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <silent> <F12> :call CocActionAsync('doHover')<cr>
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
" inoremap <expr> <Space> pumvisible() ? "\<C-y> " : "\<Space>"

" Fzf
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>m :Marks<CR>
nnoremap <leader>? :Helptags<CR>
nnoremap <leader>t :Filetype<CR>
nnoremap z= :call FzfSpell()<CR>
nnoremap <leader>s [s<Cmd>call FzfSpell()<CR>
nnoremap <leader>S ]s<Cmd>call FzfSpell()<CR>

" Goyo
nnoremap <leader>g :call ToggleGoyo()<CR>

