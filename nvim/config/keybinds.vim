""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL KEY BINDINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Escape and Editing Shortcuts
imap <C-j> <Esc>
inoremap <C-c> <Nop>
nnoremap <C-c> <Nop>
xnoremap <C-c> y:call system("pbcopy", @")<CR>
xnoremap <CR> <Esc>

" Search and Highlight Management
nnoremap <leader><CR> :nohlsearch<CR>
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
nnoremap <C-d> yyp
nnoremap <C-p> yy:Commentary<CR>p
nnoremap dae :%!pbpaste<CR>

" Visual Block Mode
nnoremap vv <Esc><Esc><C-V>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN KEY BINDINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vimwiki
nnoremap <leader>wi :VimwikiDiaryIndex 1<CR>
nnoremap <leader>n :VimwikiMakeDiaryNote 1<CR>:call InsertTime()<CR>
nnoremap <leader>i :VimwikiIncrementListItem<CR>
nnoremap <leader>d :VimwikiDecrementListItem<CR>

" VimSneak
map f <Plug>Sneak_s
map F <Plug>Sneak_S

" YouCompleteMe
map <F12> <plug>(YCMHover)
nnoremap <silent> <F9> :execute "YcmCompleter RefactorRename" input("Rename to: ")<CR>

" CoC
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Space> pumvisible() ? "\<C-y> " : "\<Space>"

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
