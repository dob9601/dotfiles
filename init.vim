if &compatible
    set nocompatible               " Be iMproved
endif

call plug#begin('~/.vim/plugged')

" Autocompletion - CoC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Statusbar
Plug 'hoob3rt/lualine.nvim'

" ???
Plug 'alec-gibson/nvim-tetris'
Plug 'seandewar/nvimesweeper'

" aksdopask
" aksdopask
" Bazbuz
" aksdopask

" Colourschemes
Plug 'folke/tokyonight.nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'sainnhe/sonokai'

" Highlight F/f/T/t jumps
Plug 'deris/vim-shot-f' 

" Git wrappers
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/git-messenger.vim'

" Commenting shortcuts
Plug 'preservim/nerdcommenter'

" Start page
" Plug 'mhinz/vim-startify'
" Plug 'startup-nvim/startup.nvim'
Plug 'goolord/alpha-nvim'

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

" Telescope
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

" ----------------------- Vim ----------------------
filetype plugin indent on
syntax enable

set splitbelow
set splitright

set updatetime=300

" Speedy insert escape
imap jj <esc>d2h

" Show find and replace as it happens. Open buffer at bottom to show changes throughout file.
set inccommand=split
"
" Enable mouse support
set mouse=a
"
" Default to using the system clipboard
set clipboard=unnamedplus

autocmd BufNewFile,BufRead *.cwl setlocal filetype=cwl syntax=yaml
autocmd BufNewFile,BufRead *.html.tera setlocal syntax=htmldjango
autocmd BufNewFile,BufRead *.pw setlocal filetype=pw
autocmd BufNewFile,BufRead *.pw setlocal filetype=pw

let g:python3_host_prog = '/usr/bin/python3'

" => Colorscheme
set termguicolors

" Sonokai
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1

" Material
let g:material_style = 'deep ocean'

colorscheme sonokai

" Conceal the tildes at the end of a buffer, makes start page look nicer
highlight EndOfBuffer guifg=bg

" ----------------------- Coc ----------------------
let g:coc_global_extensions = [
    \ 'coc-yank', 'coc-snippets', 'coc-pairs',
    \ 'coc-html', 'coc-explorer', 'coc-yaml',
    \ 'coc-tsserver', 'coc-sh', 'coc-rust-analyzer',
    \ 'coc-pyright', 'coc-json', 'coc-docker', 'coc-css',
    \ 'coc-java']

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
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nnoremap <Leader>p :CocCommand<CR>
nnoremap <Leader>f :call CocAction('format')<CR>
nnoremap <Leader><Leader> :CocAction<CR>

nmap <Leader>rn <Plug>(coc-rename)
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gr <Plug>(coc-references)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

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

" -------------------- Bufferline ------------------

nnoremap <silent><Leader>b :BufferLinePick<CR>
nnoremap <silent><A-b>d :bd<CR>
nnoremap <silent><A-b>n :BufferLineCycleNext<CR>
nnoremap <silent><A-b>p :BufferLineCyclePrev<CR>

lua << EOF
require("bufferline").setup {
    options = {
        diagnostics = "coc",
        separator_style = "slant",
        always_show_bufferline = false
    }
}
EOF

" ----------------------- Git ----------------------

" Fugitive bindings
nnoremap ga :Git add %<CR>
nnoremap gc :Git commit<CR>
nnoremap gs :Git status<CR>

" Gutter marks
let g:gitgutter_signs=0
let g:gitgutter_highlight_linenrs=1
highlight GitGutterAddLineNr guifg=lightgreen
highlight GitGutterChangeLineNr guifg=lightblue
highlight GitGutterDeleteLineNr guifg=lightred
highlight GitGutterChangeDeleteLineNr guifg=lightred

" Git Messenger
let g:git_messenger_no_default_mappings = v:true
nnoremap <silent><C-g> :GitMessenger<CR>

" ----------------- Start Screen -----------------

lua << EOF
local io = require "io"
local handle = assert(io.popen('bash -c history', 'r'))
print(assert(handle:read('*a')))
EOF

" Cursed hack to disable statusline completely for alpha buffer
autocmd BufEnter * set laststatus=2
autocmd FileType alpha setlocal laststatus=0

lua << EOF
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⢦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", 
    "⠀⠀⠀⣴⢟⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⢛⣷⣎⡠⡀⠛⢤⣠⣼⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⡿⣦⡀", 
    "⠀⠀⠀⣿⠀⠌⡨⠈⠌⡈⠌⡈⠌⡈⠌⠨⠠⣹⣗⠜⡌⡒⡄⢹⡷⠀⠅⢊⠈⠌⠄⠅⠡⠡⠨⢈⢐⡸⣿⡇", 
    "⠀⠀⠀⠻⣷⣽⠊⠨⠐⠠⠁⠔⢐⠠⢱⢹⣼⣿⡣⢣⢑⠕⡜⢜⢿⣮⠝⢸⠨⠠⠡⢈⢂⠡⠨⢠⢺⣼⠟⠁", 
    "⠀⠀⠀⠀⠀⣿⠀⠨⠈⠌⠨⠠⢁⢂⢸⢸⣿⡪⡘⡌⢆⠇⡎⣺⠞⠁⡀⡂⠌⠄⠅⢂⢐⡠⣏⣷⠟⠁⠀⠀", 
    "⠀⠀⠀⠀⠀⣿⠀⠨⠈⠌⠨⠐⡐⠠⢸⢸⣿⡪⡘⡌⢎⣼⠞⠁⡀⡐⡀⡂⠌⠄⠅⡢⣲⣵⠟⠁⠀⠀⠀⠀", 
    "⠀⠀⠀⠀⠀⣿⠀⠨⠈⠌⠨⢐⠠⠡⢸⢸⣿⡪⢌⣮⠞⠁⢀⢐⢀⢂⢐⠐⡈⢄⢕⣼⢿⡁⠀⠀⠀⠀⠀⠀", 
    "⠀⠀⠀⠀⠀⣿⠀⠨⠈⠌⠨⢀⠂⡡⠸⣸⣿⣾⠟⠁⠀⠌⠠⢂⠐⡀⡂⢔⢔⣵⡟⢇⢄⠱⢆⡀⠀⠀⠀⠀", 
    "⠀⠀⠀⡠⠊⣿⠀⠨⢈⠌⠨⢀⠂⡂⢜⢺⠟⠁⢀⠂⡡⠁⠅⡂⠌⣀⢖⣵⣟⢗⠱⡑⡜⢔⢄⠙⣤⠀⠀⠀", 
    "⠀⡠⠊⡰⡨⣿⠀⠨⠠⠈⠌⡐⢐⠐⢸⠄⡀⢂⠂⡂⢂⢁⠂⡂⣦⣳⡿⢝⢌⢆⢣⢱⠸⡐⡅⢇⢄⠙⢆⡀", 
    "⠈⠛⣵⡪⡌⣿⠀⠨⠐⡁⠅⡐⢐⠈⠌⡀⡂⢂⠂⡂⢂⠐⡜⣵⣟⢏⢎⠪⡢⡑⡕⢌⠎⡜⢌⢪⡲⡯⠋⠀", 
    "⠀⠀⠀⠻⢮⣿⠀⠨⠐⡐⢐⠐⡐⠨⠐⡀⡂⢂⠂⣢⡞⠩⢉⡯⢢⠱⡘⡌⢆⢣⢊⢎⢪⢸⢜⡯⠋⠀⠀⠀", 
    "⠀⠀⠀⠀⠈⣿⠀⠨⠐⡐⢐⠐⠠⠡⠨⢀⠂⡂⣒⣼⣶⢷⢞⢎⠪⣊⢪⠸⡨⡢⠣⣊⡶⡻⠋⠀⠀⠀⠀⠀", 
    "⠀⠀⠀⠀⠀⣿⠀⠨⢐⠐⡐⢈⠌⠄⠅⠂⣆⣿⣛⠛⡛⣻⡪⣟⡛⠛⡛⣼⡜⢛⠛⠻⣯⠞⢛⢛⢳⠀⠀⠀", 
    "⠀⠀⠀⠀⠀⣿⠀⠨⢀⠂⡂⠂⠄⢅⡸⣪⣾⢫⠇⡂⢂⡟⡌⡎⡐⢡⢴⢤⡌⠄⠌⡦⠦⡬⢐⠀⡾⠀⠀⠀", 
    "⠀⠀⠀⠀⠀⣿⠀⠨⠐⡐⠠⠡⢥⣪⣾⢻⠨⡞⡐⠠⡽⡘⣼⠁⡂⣝⣞⣽⠃⠌⣸⠀⢠⢃⠂⢼⠁⠀⠀⠀", 
    "⠀⠀⠀⠀⠀⣿⠀⠨⢐⠠⡡⣣⡿⠻⢵⡱⣽⢀⢂⣹⡏⣪⠏⡐⢸⡿⠋⡟⠨⢰⡇⠀⡾⠐⣈⣎⠀⠀⠀⠀", 
    "⠀⠀⠀⠀⠀⠙⠷⠿⠿⠷⠿⠋⠀⠀⠈⠹⣷⡶⡶⡶⡯⢺⡶⡶⠓⠃⠘⠚⠒⠓⠃⠀⠓⠓⠒⠚⠀⠀⠀⠀", 
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⣧⢣⢞⣽⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", 
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠹⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", 
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "e", "  New File" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "  Find Files", ":Telescope find_files<CR>"),
    dashboard.button( "g", "  Grep Files", ":Telescope live_grep<CR>"),
    dashboard.button( "r", "  Recent Files"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "s", "  Settings" , ":e $MYVIMRC | vsplit | CocConfig<CR> | :wincmd p<CR>"),
    dashboard.button( "q", "  Quit", ":qa<CR>"),
}

local fortune = require("alpha.fortune") 
dashboard.section.footer.val = fortune()

alpha.setup(dashboard.opts)
EOF

"--------------------   Ale  -------------------- 
let g:ale_echo_cursor= 0
let g:ale_cursor_detail=1
let g:ale_floating_preview = 1
let g:ale_floating_window_border = ['│', '─', '┌', '┐', '┘', '└']
let g:ale_linters = {
    \ 'python': [],
    \ 'haskell': [],
    \ 'rust': [],
    \ 'typescript': []
    \}

" Django
set wildignore +=*/staticfiles/*,*/node_modules/*,*/env/*

" --------------

set nowrap " Disable text-wrap
set number " Show line numbers

set signcolumn=yes:1

runtime mswin.vim " Enable mswin style bindings
nnoremap <C-s> :w<CR>

tnoremap <C-[> <C-\><C-n> " Change mapping to make terminal easier to exit

set tabstop=4 shiftwidth=4 expandtab

set cursorline " Make cursor easier to find

" Make the delete button not yank
nnoremap <del> "_x
nnoremap x "_x

set scrolloff=10

"------------------ Indent Line ----------------- 

let g:indentLine_char = '▏'
set colorcolumn=9999999 " Workaround to fix bug with nvim highlighting
let g:indentLine_fileTypeExclude = ['startify', 'help', 'startup', 'alpha']

"------------------- Telescope ------------------ 

nnoremap <A-p> :Telescope<CR>
nnoremap <silent> <C-p> :<C-u>Telescope find_files<CR>

lua << EOF
local actions = require("telescope.actions")
require('telescope').setup {
    defaults = {
        file_ignore_patterns = { 'node_modules', '__pycache__', '**/migrations', 'staticfiles', 'env', 'target' },
        initial_mode = 'insert',
        mappings = {
            i = {
                ["<esc>"] = actions.close
            }
        }
    },
    pickers = {
        find_files = {
            theme = "ivy"
        },
        oldfiles = {
            theme = "ivy"
        }
    }
}
require('telescope').load_extension('coc')
EOF

"-------------------- Lualine ------------------- 

lua << EOF
require('lualine').setup({
    options = {
        theme = 'sonokai',
        disabled_filetypes = {'alpha'}
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
EOF

"--------------------- Todo ------------------------

lua << EOF
require('todo-comments').setup {
}
EOF

"------------------ Treesitter ---------------------

lua << EOF
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
EOF
