if &compatible
    set nocompatible               " Be iMproved
endif

" Disable HTML polyglot due to dodgy inline-js indents
let g:polyglot_disabled = ['html'] " breaks java

call plug#begin('~/.vim/plugged')

set updatetime=300

" Autocompletion - CoC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Statusbar
Plug 'hoob3rt/lualine.nvim'

" Show Git Blames inline
Plug 'f-person/git-blame.nvim'

" Colourschemes
Plug 'folke/tokyonight.nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'sainnhe/sonokai'

" Highlight F/f/T/t jumps
Plug 'deris/vim-shot-f' 

" Git wrapper
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Commenting shortcuts
Plug 'preservim/nerdcommenter'

" Start page
Plug 'mhinz/vim-startify'

" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

" Better top bar
Plug 'akinsho/bufferline.nvim'

" Colour code highlighting
Plug 'ap/vim-css-color'

" Zen mode
Plug 'junegunn/goyo.vim'

Plug 'honza/vim-snippets'

" Todo highlighting
Plug 'nvim-lua/plenary.nvim'
Plug 'folke/todo-comments.nvim'

" Fuzzy finder
Plug 'nvim-telescope/telescope.nvim'
Plug 'fannheyward/telescope-coc.nvim'

" Ron highlighting
Plug 'ron-rs/ron.vim'

" Indent guides
Plug 'yggdroot/indentline'

" UNIX Helper
Plug 'tpope/vim-eunuch'

" Tagbar
Plug 'preservim/tagbar'

" Ale
Plug 'dense-analysis/ale'

" Marks in gutter
Plug 'kshenoy/vim-signature'

" Treesitter synax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

" Required:
filetype plugin indent on

autocmd BufNewFile,BufRead *.cwl setlocal filetype=cwl syntax=yaml
autocmd BufNewFile,BufRead *.html.tera setlocal syntax=htmldjango
autocmd BufNewFile,BufRead *.pw setlocal filetype=pw

syntax enable

let g:python3_host_prog = '/usr/bin/python3'

" --------------------   Coc    --------------------
inoremap <silent><expr> <c-space> coc#refresh()
" Tab stuff
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

let g:coc_snippet_next = '<tab>'

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
nnoremap <Leader>p :CocCommand<CR>
nnoremap <Leader>f :call CocAction('format')<CR>

nnoremap <Leader><Leader> :CocAction<CR>

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <Leader>rn <Plug>(coc-rename)
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gr <Plug>(coc-references)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

set inccommand=nosplit

" ----------------- Indent Blankline ---------------

set colorcolumn=9999999 " Workaround to fix bug with nvim highlighting

" -------------------- Bufferline ------------------

let bufferline = get(g:, 'bufferline', {})
let bufferline.auto_hide = v:false
nnoremap <silent><Leader>b :BufferLinePick<CR>
nnoremap <silent><A-b>d :BufferClose<CR>

" ----------------------- Git ----------------------
nnoremap ga :Git add %<CR>
nnoremap gc :Git commit<CR>
nnoremap gs :Git status<CR>

" -------------------- Startify --------------------
let g:startify_custom_header = [
            \ '     █████████ ██████████ ██████████ ███    ███ ███ ███████████████',
            \ '     ███▀▀▀███ ███    ███ ███    ███ ███    ███ ███ ███▀▀▀███▀▀▀███',
            \ '     ███   ███ ███    ███ ███    ███ ███    ███ ███ ███   ███   ███',
            \ '     ███   ███ ███▄▄▄     ███    ███ ███    ███ ███ ███   ███   ███',
            \ '     ███   ███ ███▀▀▀     ███    ███ ███    ███ ███ ███   ███   ███',
            \ '     ███   ███ ███    ███ ███    ███ ███    ███ ███ ███   ███   ███',
            \ '     ███   ███ ███    ███ ███    ███ ███    ███ ███ ███   ███   ███',
            \ '     ███   ███ ██████████ ██████████ ██████████ ███ ███   ███   ███',
            \ ]

let g:startify_bookmarks = ['~/.config/nvim/init.vim']

" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('s:gitModified'),  'header': ['   Git Modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   Git Untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]

"--------------------   Ale  -------------------- 
" let g:ale_disable_lsp = 1
let g:ale_echo_cursor= 0
let g:ale_cursor_detail=1
let g:ale_floating_preview = 1
let g:ale_floating_window_border = ['║', '═', '╔', '╗', '╝', '╚']
let g:ale_linters = {
    \ 'python': [],
    \ 'haskell': [],
    \ 'rust': [],
    \ 'typescript': []
    \}

" Django
set wildignore +=*/staticfiles/*,*/node_modules/*,*/env/*

" Colour Scheme
set termguicolors

" Gutter marks
let g:gitgutter_signs=0
let g:gitgutter_highlight_linenrs=1
highlight GitGutterAddLineNr guifg=lightgreen
highlight GitGutterChangeLineNr guifg=lightblue
highlight GitGutterDeleteLineNr guifg=lightred
highlight GitGutterChangeDeleteLineNr guifg=lightred

let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1
colorscheme sonokai

let g:fugitive_gitlab_domains = ['https://dev-gitlab.londc.genomicsplc.com/']
let g:gitlab_api_keys = {'dev-gitlab.londc.genomicsplc.com': 'z-fUazcJnmsf696kruat'}

" Move cursor to new split
set splitright
set splitbelow

" --------------

set nowrap " Disable text-wrap
set number " Show line numbers

set signcolumn=yes:1
" autocmd BufRead,BufNewFile * setlocal signcolumn=number " Enable signcolumn by default
highlight clear SignColumn " Clear highlight from sign column

runtime mswin.vim " Enable mswin style bindings - until I break the habit of <C-s>

tnoremap <C-[> <C-\><C-n> " Change mapping to make terminal easier to exit

set tabstop=4 shiftwidth=4 expandtab

set mouse=a " Enable mouse support

set clipboard+=unnamedplus " Always use system clipboard

set cursorline " Make cursor easier to find

nnoremap <del> "_x " Make the delete button not yank

set concealcursor=""

set scrolloff=10

" Function to delete all hidden buffers
function DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction

nnoremap <silent> <c-K> :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
"
"------------------ Indent Line ----------------- 

let g:indentLine_char = '|'

"------------------- Telescope ------------------ 

nnoremap <A-p> :Telescope<CR>
nnoremap <silent> <C-p> :<C-u>Telescope find_files<CR>

lua << EOF
require('lualine').setup({
    options = {
        theme = 'auto'
    },

    sections = {
        lualine_a = {'mode'},
        lualine_b = {
            {
                'branch',
                icon = ''
            },
            { 'diagnostics', sources = {'coc', 'ale'} },
            {
                'diff',
                symbols = {added = ' ', modified = ' ', removed = ' '},
            }
        },
        lualine_c = {'g:coc_status', 'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },

    extensions = {'fugitive'}
})

require('todo-comments').setup {
}

require('telescope').setup {
    defaults = {
        file_ignore_patterns = { 'node_modules', '__pycache__', '**/migrations', 'staticfiles', 'env', 'target' }
    },
    pickers = {
        find_files = {
            theme = "ivy"
        }
    }
}
require('telescope').load_extension('coc')

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {  },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require("bufferline").setup {
    options = {
        diagnostics = "coc",
        separator_style = "slant"
    }
}
EOF
