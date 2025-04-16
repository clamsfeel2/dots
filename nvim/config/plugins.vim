if empty(glob("$HOME/.config/nvim/autoload/plug.vim"))
	silent execute "!curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
endif
call plug#begin('$HOME/.config/nvim/vimplug')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'ludovicchabant/vim-gutentags'
Plug 'airblade/vim-gitgutter'
Plug 'justinmk/vim-sneak'
Plug 'ap/vim-css-color'
Plug 'liuchengxu/vim-which-key'
Plug 'farmergreg/vim-lastplace'
Plug 'preservim/tagbar'
Plug 'gbprod/nord.nvim'
" Plug 'Valloric/YouCompleteMe'
call plug#end()

""" VIMWIKI
let $PDFS_S24=$HOME . "/Documents/Mollusk/Documents/PDF/School/Summer2024/Classes"
let $PDFS_F24=$HOME . "/Documents/Mollusk/Documents/PDF/School/Fall2024/Classes"
let $PDFS_SP25=$HOME . "/Documents/Mollusk/Documents/PDF/School/Spring2025/Classes"
let g:vimwiki_list = [{
			\ 'path': '$HOME/Documents/Mollusk/Documents/Notes/Markdown/Personal/Journal',
			\ 'auto_diary_index': 1,
			\ 'syntax': 'markdown',
			\ 'ext': '.md',
			\ 'path_html': '$HOME/Documents/Mollusk/Documents/Notes/frontend/html/Personal/Journal', 'custom_wiki2html': '$HOME/Documents/Mollusk/Documents/Notes/scripts/vimwiki_markdown.sh', 'html_filename_parameterization': 1,
			\ 'template_path': '$HOME/Documents/Mollusk/Documents/Notes/frontend/assets/pages/general',
			\ 'template_default': 'default',
			\ 'template_ext': '.html'},
			\ {
			\ 'path': '$HOME/Documents/Mollusk/Documents/Notes/frontend/markdown/',
			\ 'auto_toc': 1,
			\ 'listsyms': ' wx',
			\ 'syntax': 'markdown',
			\ 'ext': '.md',
			\ 'path_html': '$HOME/Documents/Mollusk/Documents/Notes/frontend/html', 'custom_wiki2html': '$HOME/Documents/Mollusk/Documents/Notes/scripts/vimwiki_markdown.sh', 'html_filename_parameterization': 1,
			\ 'template_path': '$HOME/Documents/Mollusk/Documents/Notes/frontend/assets/pages/general',
			\ 'template_default': 'default',
			\ 'template_ext': '.html'}]
let g:vimwiki_ext2syntax = {".md": "markdown", ".markdown": "markdown", ".mdown": "markdown"}
let g:vimwiki_listsyms_propagate = 0
" Whether vimwiki should treat all .md files as vimwiki or not 1 for yes 0 for no
let g:vimwiki_global_ext = 1
" Whether vimwiki automatically ads .md at the end of link -- needed for github links to work
let g:vimwiki_markdown_link_ext = 1
" To turn off enter to create links (also turns off enter to follow links...)
" let g:vimwiki_key_mappings = {'links': 0,}

""" AUTOPAIRS
" let g:AutoPairsFlyMode = 1
" let g:AutoParisShortcutBackInsert = '<C-h>'
let g:AutoPairsShortcutJump = '<C-l>'
let g:AutoPairsShortcutFastWrap = '<C-k>'

""" WHICHKEY
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
let g:which_key_map = {}
let g:which_key_map["<CR>"] = "Clear Search Highlight"
let g:which_key_map["v"] = "Show Available Commands"
let g:which_key_map["c"] = "Commit with gpc"
let g:which_key_map["l"] = "Next Tab"
let g:which_key_map["h"] = "Previous Tab"
let g:which_key_map["1"] = "Go to Tab 1"
let g:which_key_map["2"] = "Go to Tab 2"
let g:which_key_map["3"] = "Go to Tab 3"
let g:which_key_map["4"] = "Go to Tab 4"
let g:which_key_map["5"] = "Go to Tab 5"
let g:which_key_map["6"] = "Go to Tab 6"
let g:which_key_map["7"] = "Go to Tab 7"
let g:which_key_map["8"] = "Go to Tab 8"
let g:which_key_map["9"] = "Go to Tab 9"
let g:which_key_map["wi"] = "Open Vimwiki Diary Index"
let g:which_key_map["n"] = "Create Diary Note"
let g:which_key_map["i"] = "Increment List Item"
let g:which_key_map["d"] = "Decrement List Item"
let g:which_key_map["f"] = "Find Files"
let g:which_key_map["b"] = "Find Buffers"
let g:which_key_map["m"] = "Find Marks"
let g:which_key_map["?"] = "Search Help Tags"
let g:which_key_map["t"] = "Search Filetypes"
let g:which_key_map["s"] = "Fix Prev Spelling Error"
let g:which_key_map["S"] = "Fix Next Spelling Error"
let g:which_key_map["g"] = "Toggle Goyo Mode"
let g:which_key_map["a"] = "Window Mode"
let g:which_key_map["w"] = { "name": "Vimwiki Bindings" }
call which_key#register('<Space>', 'g:which_key_map')

""" VIMAIRLINE
let g:airline_theme='angr'
let g:airline_statusline_ontop=0
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.colnr = '| '
let g:airline_symbols.maxlinenr = ' '
let g:airline_symbols.whitespace = ''
let g:airline_symbols.branch = ''

""" FZF
" let g:fzf_buffers_jump = 0
" Track the last opened directory
let $FZF_DEFAULT_OPTS = '--prompt=" " --bind ctrl-t:toggle --bind ctrl-d:toggle+down --bind ctrl-u:up+toggle --bind ctrl-a:select-all --bind ctrl-alt-a:deselect-all --reverse --cycle --border'
let $FZF_DEFAULT_COMMAND = "fd --type f --hidden --glob --exclude '*.log' --exclude '*.sqlite3' --exclude '*.ttf' --exclude '*woff' --exclude 'woff2' --exclude vimplug --exclude spell --exclude node_modules --exclude pyvenv --exclude .git --exclude .DS_Store --exclude .CFUserTextEncoding --exclude .localized"

""" GOYO
let g:goyo_width = 80
let g:goyo_height = 100
let g:goyo_linenr = 1

""" GITGUTTER
let g:gitgutter_map_keys = 0

""" YOUCOMPLETEME
" Uncomment to turn inlay hints on
" let g:ycm_enable_inlay_hints = 1
let g:ycm_always_populate_location_list = 1
" turn off automatic YouCompleteMe cursor hover info
let g:ycm_auto_hover = ""

""" GUTENTAGS
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ["*.cpp", "*.c", "package.json", "*.js", "*.py*", ".git"]
let g:gutentags_cache_dir = expand("$HOME/.cache/vim/ctags/")
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_exclude = [
			\ "build", "dist", "bin",
			\ "cache", "docs", "example",
			\ "bundle", "vendor", "compiled",
			\ "node_modules",
			\ "bower_components",
			\ "vimrc",
			\ ".*rc*", "*.scss", "*.css", "*.json",
			\ "*.mp3", "*.ogg", "*.flac",
			\ "*bundle*.js", "*build*.js",
			\ "*.bmp", "*.gif", "*.ico", "*.jpg", "*.png", "*.svg",
			\ "*.md", "*.pdf", "*.doc", "*.docx", "*.ppt", "*.pptx",
			\ "*.tmp", "*.bak", "*.rar", "*.zip", "*.tar", "*.tar.gz", "*.tar.xz", "*.tar.bz2",
			\ "*.min.*", "*.map", "*.pyc", "*.class", "*.sln", "*.Master", "*.csproj", "*.cache", 
			\ "*.pdb", "*.less", "*.csproj.user", "*.swp", "*.swo", "*-lock.json", "*.lock",
			\ "*.git", "*/tests/*", "tags*", "cscope.*"]
