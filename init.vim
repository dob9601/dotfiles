if &compatible
    set nocompatible               " Be iMproved
endif

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Disable HTML polyglot due to dodgy inline-js indents
let g:polyglot_disabled = ['html'] " breaks java

call plug#begin('~/.vim/plugged')



" Autocompletion - CoC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Statusbar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Colourscheme
Plug 'ayu-theme/ayu-vim'

" Git
Plug 'tpope/vim-fugitive' " Wrapper
Plug 'airblade/vim-gitgutter' " Git in gutter
Plug 'tveskag/nvim-blame-line' " Git blame

" Improved syntax
Plug 'sheerun/vim-polyglot'

" Ranger
Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'

" Start page
Plug 'mhinz/vim-startify'

" Icons
Plug 'ryanoasis/vim-devicons'

" Colour code highlighting
Plug 'ap/vim-css-color'

" Zen mode
Plug 'junegunn/goyo.vim'

Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" Pairs-closing
" Plug 'jiangmiao/auto-pairs'

" Fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'

" Ron highlighting
Plug 'ron-rs/ron.vim'

" Indent guides
Plug 'yggdroot/indentline'

" UNIX Helper
Plug 'tpope/vim-eunuch'

" Tagbar
Plug 'preservim/tagbar'

" GraphViz
Plug 'wannesm/wmgraphviz.vim'

" Ale
Plug 'dense-analysis/ale'

" Marks in gutter
Plug 'kshenoy/vim-signature'

" Haskell
Plug 'neovimhaskell/haskell-vim'

call plug#end()

" Required:
filetype plugin indent on
syntax enable

let g:python3_host_prog = '/usr/bin/python'

" Plugin Config -----------

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0

let g:airline_left_sep =  "\uE0BC "
let g:airline_left_alt_sep = "\uE0BD "

let g:airline_right_sep = "\uE0BE "
let g:airline_right_alt_sep = "\uE0BF "

let g:airline_theme='ayu_mirage'

let g:airline#extensions#tabline#formatter = 'unique_tail'
" Snippets
let g:UltiSnipsExpandTrigger="<nop>"

" Coc
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

nnoremap <Leader><Leader> :CocAction<CR>

" ---
nmap <Leader>rn <Plug>(coc-rename)
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gr <Plug>(coc-references)

" Git
nnoremap ga :Git add %<CR>
nnoremap gc :Git commit<CR>
nnoremap gs :Git status<CR>

" Startify
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

" Ale
let g:ale_echo_cursor= 0
let g:ale_cursor_detail=1
let g:ale_floating_preview = 1
let g:ale_floating_window_border = ['║', '═', '╔', '╗', '╝', '╚']
let g:ale_linters = {
    \ 'python': [],
    \ 'haskell': [],
    \ 'rust': [] 
    \}
" 'cargo', 'rls']
" let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
let g:ale_rust_rls_toolchain = 'stable'

" let g:ale_open_list = 0
" let g:ale_set_quickfix = 0
" let g:ale_virtualtext_cursor = 1
" let g:ale_virtualtext_prefix = '| '
" let g:ale_echo_cursor = 0
" let g:ale_enabled = 0

" let g:ale_lint_on_text_changed = 0
" let g:ale_lint_on_enter = 1
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_insert_leave = 0

" Django
set wildignore +=*/staticfiles/*

" Colour Scheme
set termguicolors
let ayucolor="mirage"
colorscheme ayu

" Gutter marks
highlight SignatureMarkText guifg=#5CCFE6

" Split handling
nnoremap <silent> <A-Left> <C-w>h
nnoremap <silent> <A-Down> <C-w>j
nnoremap <silent> <A-Up> <C-w>k
nnoremap <silent> <A-Right> <C-w>l
inoremap <silent> <A-Left> <C-O><C-w>h
inoremap <silent> <A-Down> <C-O><C-w>j
inoremap <silent> <A-Up> <C-O><C-w>k
inoremap <silent> <A-Right> <C-O><C-w>l

" Move cursor to new split
set splitright
set splitbelow

" --------------

set nowrap " Disable text-wrap
set number " Show line numbers

autocmd BufRead,BufNewFile * setlocal signcolumn=yes " Enable signcolumn by default
highlight clear SignColumn " Clear highlight from sign column

runtime mswin.vim " Enable mswin style bindings - until I break the habit of <C-s>

tnoremap <C-[> <C-\><C-n> " Change mapping to make terminal easier to exit

set tabstop=4 shiftwidth=4 expandtab

set mouse=a " Enable mouse support

set clipboard+=unnamedplus " Always use system clipboard

set cursorline " Make cursor easier to find

nnoremap <del> "_x " Make the delete button not yank

set noequalalways " Disable equalalways so splits aren't resized to be equal when another split is made

" Custom filetype stuff
autocmd BufNewFile,BufRead *.pw set filetype=pw

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
