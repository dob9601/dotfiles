if &compatible
    set nocompatible               " Be iMproved
endif

call plug#begin('~/.vim/plugged')

" Language server
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'folke/trouble.nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'ray-x/lsp_signature.nvim'

" Neorg
Plug 'nvim-neorg/neorg'

" Show current context
Plug 'wellle/context.vim'

" Targets
Plug 'wellle/targets.vim'

" Discord
Plug 'andweeb/presence.nvim'

" Show key combos
Plug 'folke/which-key.nvim'

" Bracket closing
Plug 'windwp/nvim-autopairs'

" Don't shift windows when opening other panes
Plug 'luukvbaal/stabilize.nvim'

" better JSX support
Plug 'maxmellon/vim-jsx-pretty'

" Statusbar
Plug 'hoob3rt/lualine.nvim'

" Venn
Plug 'jbyuki/venn.nvim'

" ???
Plug 'alec-gibson/nvim-tetris'
Plug 'seandewar/nvimesweeper'

" Infer indents
Plug 'tpope/vim-sleuth'
Plug 'Vimjas/vim-python-pep8-indent'

" Colourschemes
Plug 'folke/tokyonight.nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'sainnhe/sonokai'

" Highlight F/f/T/t jumps
Plug 'deris/vim-shot-f' 

" Git wrappers
Plug 'tpope/vim-fugitive' " General wrapper
Plug 'airblade/vim-gitgutter' " Show changes in gutter
Plug 'rhysd/git-messenger.vim' " Blame for current line
Plug 'rhysd/conflict-marker.vim' " Merge conflicts
Plug 'pwntester/octo.nvim' " GitHub
Plug 'sindrets/diffview.nvim' " Better diff viewing

" Commenting shortcuts
Plug 'preservim/nerdcommenter'

" Start page
" Plug 'mhinz/vim-startify'
" Plug 'startup-nvim/startup.nvim'
Plug 'goolord/alpha-nvim'

" Don't break layout when closing 
Plug 'moll/vim-bbye'

" Notifications
Plug 'rcarriga/nvim-notify'

" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

" Better top bar
Plug 'akinsho/bufferline.nvim'

" Colour code highlighting
Plug 'ap/vim-css-color'

" Zen mode
Plug 'folke/zen-mode.nvim'

" FIXME: UNNEEDED??
Plug 'honza/vim-snippets'

" Todo highlighting
Plug 'nvim-lua/plenary.nvim'
Plug 'folke/todo-comments.nvim'

" Telescope
Plug 'nvim-telescope/telescope.nvim'

" Ron highlighting
Plug 'ron-rs/ron.vim'

" Indent guides
Plug 'lukas-reineke/indent-blankline.nvim'

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

set shortmess+=A

set updatetime=300

" Show find and replace as it happens. Open buffer at bottom to show changes throughout file.
set inccommand=split
"
" Enable mouse support
set mouse=a

" Window title stuff
set title
set titlestring=nvim\ %F

set wildignore +=*/staticfiles/*,*/node_modules/*,*/env/*

set nowrap " Disable text-wrap
set number " Show line numbers

set signcolumn=yes:2

runtime mswin.vim

tnoremap <C-[> <C-\><C-n> " Change mapping to make terminal easier to exit

set tabstop=4 shiftwidth=4 expandtab

set cursorline " Make cursor easier to find

" Make the delete button not yank
nnoremap <del> "_x
nnoremap x "_x

set fillchars+=diff:╱

set timeoutlen=500

set scrolloff=10


autocmd TermOpen * setlocal scl=no nonumber

" Default to using the system clipboard
set clipboard=unnamedplus

" Highlight yanked text
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=500 }
augroup END

autocmd BufNewFile,BufRead *.cwl setlocal filetype=cwl syntax=yaml
autocmd BufNewFile,BufRead *.md setlocal linebreak wrap
autocmd BufNewFile,BufRead *.html.tera setlocal syntax=htmldjango
autocmd BufNewFile,BufRead *.pw setlocal filetype=pw
autocmd BufNewFile,BufRead *.awg setlocal filetype=yaml
autocmd BufNewFile,BufRead *.norg setlocal conceallevel=2

let g:python3_host_prog = '/usr/bin/python3'

" ----------------- Colourscheme -----------------
set termguicolors

colorscheme tokyonight

lua << EOF
require('nvim-autopairs').setup{}
EOF

" Conceal the tildes at the end of a buffer, makes start page look nicer
highlight EndOfBuffer guifg=bg
" -----------------     Norg     -----------------
lua << EOF
require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {},
        ["core.gtd.base"] = {
            config = {
                workspace = "home",
            }
        },
        ["core.presenter"] = {
           config = {
                zen_mode = "zen-mode",
           }
        },
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    work = "~/notes/work",
                    home = "~/notes/home",
                }
            }
        }
    }
}
EOF
" -----------------    Context   -----------------
let g:context_enabled = 0

inoremap <silent><A-c> <C-o>:ContextPeek<CR>
nnoremap <silent><A-c> :ContextPeek<CR>

" -----------------   Zen mode   -----------------
lua << EOF
  require("zen-mode").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

" -----------------      LSP     -----------------

lua << EOF
require("lsp_signature").setup({
    doc_lines = 0,
    toggle_key = "<A-g>",
    zindex = 1
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua require("telescope.builtin").lsp_type_definitions()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader><leader>', '<cmd>lua require("telescope.builtin").lsp_code_actions()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    if client.resolved_capabilities.document_highlight then
        vim.cmd [[
          hi! LspReferenceRead cterm=underline gui=underline
          hi! LspReferenceText cterm=underline gui=underline
          hi! LspReferenceWrite cterm=underline gui=underline
          augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd! CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
        ]]
    end
end

local lsp_installer = require("nvim-lsp-installer")

vim.g.coq_settings = {
    auto_start = 'shut-up',
    keymap = { recommended = false },
    display = {
	pum = {
	    kind_context = {" ❲", "❳"},
	    fast_close = true,
	},
	preview = {
	    border = "rounded"
	},
	icons = {
	    mode = "short",
	}
    },
    limits = {
	completion_auto_timeout = 0.12
    },
    clients = {
        buffers = {
            enabled = true,
            weight_adjust = -1.9,
        },
        tree_sitter = {
            enabled = true,
            weight_adjust = -1.5
        },
        lsp = {
            enabled = true,
            weight_adjust = 1.5,
            resolve_timeout = 0.12,
        },
        snippets = {
            enabled = true,
            weight_adjust = 1.9
        },
        tags = {
	    enabled = false,
            weight_adjust = -1.5
        }
    }
}
vim.api.nvim_set_keymap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

local npairs = require('nvim-autopairs')
npairs.setup({ map_bs = false, map_cr = false })

_G.MUtils = {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
vim.api.nvim_set_keymap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
vim.api.nvim_set_keymap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })

local coq = require("coq")

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local lsp_status = require("lsp-status")
lsp_status.config({
    component_separator = "  ",
    diagnostics = false,
    show_filename = false,
    current_function = true,
    status_symbol = ""
})
lsp_status.register_progress()

local servers = {
  "bashls",
  "pyright",
  "yamlls",
  "eslint",
  "tsserver",
  "ltex",
  "spectral",
  "dockerls",
  "rust_analyzer"
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end

local custom_server_opts = {
  -- Provide settings that should only apply to the "eslintls" server
  ["yamlls"] = function(opts)
      opts.settings = {
	  yaml = {
	      schemas = {
		  ["https://raw.githubusercontent.com/dob9601/jointhedots/fixup-schema/src/dotfile_schema.json"] = "/jtd.yaml"
	      }
	  }
      }
  end,
}
-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150
        }
    }

    if custom_server_opts[server.name] then
	custom_server_opts[server.name](opts)
    end

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function will take the provided server configuration and decorate it with the necessary properties
    -- before passing it onwards to lspconfig.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(coq.lsp_ensure_capabilities(opts))
end)

require("trouble").setup {
    auto_open = true,
    auto_close = false,
    height = 5,
}
EOF

" -------------------- Which Key -------------------
lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

" -------------------- Stabilize -------------------

lua << EOF
require("stabilize").setup({
    ignore = {
        filetype = {},
        buftype = {}
    },
    nested = "QuickFixCmdPost,DiagnosticChanged *"
})
EOF

" -------------------- Bufferline ------------------

nnoremap <silent><Leader>b :BufferLinePick<CR>
nnoremap <silent><Leader>d :BufferLinePickDelete<CR>
nnoremap <silent><A-b>d :Bdelete<CR>
nnoremap <silent><A-b>n :BufferLineCycleNext<CR>
nnoremap <silent><A-b>p :BufferLineCyclePrev<CR>

lua << EOF
require("bufferline").setup {
    options = {
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        always_show_bufferline = false,
        close_command = "Bdelete %d"
    },

    groups = {
        options = {
            toggle_hidden_on_enter = true -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
        },
        items = {
            {
                name = "Tests", -- Mandatory
                highlight = {gui = "underline", guisp = "blue"}, -- Optional
                priority = 2, -- determines where it will appear relative to other groups (Optional)
                icon = "", -- Optional
                matcher = function(buf) -- Mandatory
                    return buf.filename:match('%_test') or buf.filename:match('%_spec')
                end,
            },
            {
                name = "Docs",
                highlight = {gui = "undercurl", guisp = "green"},
                auto_close = false,  -- whether or not close this group if it doesn't contain the current buffer
                matcher = function(buf)
                    return buf.filename:match('%.md') or buf.filename:match('%.txt')
                end,
                separator = { -- Optional
                    style = require('bufferline.groups').separator.tab
                },
            }
        }
    }
}

EOF

" --------------------- Notify ---------------------

lua << EOF
vim.notify = require("notify")

-- Utility functions shared between progress reports for LSP and DAP

local client_notifs = {}

local function get_notif_data(client_id, token)
 if not client_notifs[client_id] then
   client_notifs[client_id] = {}
 end

 if not client_notifs[client_id][token] then
   client_notifs[client_id][token] = {}
 end

 return client_notifs[client_id][token]
end


local spinner_frames = { "◜", "◠", "◝", "◞", "◡", "◟" }

local function update_spinner(client_id, token)
 local notif_data = get_notif_data(client_id, token)

 if notif_data.spinner then
   local new_spinner = (notif_data.spinner + 1) % #spinner_frames
   notif_data.spinner = new_spinner

   notif_data.notification = vim.notify(nil, nil, {
     hide_from_history = true,
     icon = spinner_frames[new_spinner],
     replace = notif_data.notification,
   })

   vim.defer_fn(function()
     update_spinner(client_id, token)
   end, 100)
 end
end

local function format_title(title, client_name)
 return client_name .. (#title > 0 and ": " .. title or "")
end

local function format_message(message, percentage)
 return (percentage and percentage .. "%\t" or "") .. (message or "")
end

-- LSP integration
-- Make sure to also have the snippet with the common helper functions in your config!

local ltex_initial_check_occurred = false

vim.lsp.handlers["$/progress"] = function(_, result, ctx)
    local client_id = ctx.client_id

    local val = result.value

    if not val.kind then
        return
    end

    if val.message == "no results" and val.title == "Trouble" then
        return
    end

    print(vim.inspect(val))

    if vim.lsp.get_client_by_id(client_id).name == "ltex" then
        if ltex_initial_check_occurred then
            return
        elseif val.kind == "end" then
            ltex_initial_check_occurred = true
        end
    end

    local notif_data = get_notif_data(client_id, result.token)

    if val.kind == "begin" then
        local message = format_message(val.message, val.percentage)

        notif_data.notification = vim.notify(message, "info", {
            title = format_title(val.title, vim.lsp.get_client_by_id(client_id).name),
            icon = spinner_frames[1],
            timeout = false,
            hide_from_history = false,
        })

        notif_data.spinner = 1
        update_spinner(client_id, result.token)

    elseif val.kind == "report" and notif_data then
        notif_data.notification = vim.notify(format_message(val.message, val.percentage), "info", {
            replace = notif_data.notification,
            hide_from_history = false,
        })

    elseif val.kind == "end" and notif_data then
        notif_data.notification = vim.notify(
            val.message and format_message(val.message) or "Complete", "info", {
            icon = "",
            replace = notif_data.notification,
            timeout = 3000,
        })

        notif_data.spinner = nil
    end
end
EOF

" -------------------- Discord ---------------------
lua << EOF
require("presence"):setup({
    buttons = {
        { label = "GitHub Profile", url = "https://github.com/dob9601" },
        { label = "jointhedots", url = "https://github.com/dob9601/jointhedots" },
    },
})
EOF
" ---------------------- Venn ----------------------

lua << EOF
 -- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd[[setlocal ve=all]]
	vim.cmd[[IndentBlanklineDisable]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "i", "<S-r>", {noremap = true})
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
    else
	vim.cmd[[IndentBlanklineEnable]]
        vim.cmd[[setlocal ve=]]
        vim.cmd[[mapclear <buffer>]]
        vim.b.venn_enabled = nil
    end
end
-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true, silent = true })
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

highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guibg=#2f628e
highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81

lua << EOF
require("octo").setup()
EOF

" ----------------- Start Screen -----------------

"lua << EOF
"local io = require "io"
"local handle = assert(io.popen('bash -c history', 'r'))
"print(assert(handle:read('*a')))
"EOF

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
    dashboard.button( "u", "ﮮ  Update Plugins" , ":PlugUpdate<CR>"),
    dashboard.button( "n", "ﴬ  Notes" , ":Neorg workspace home<CR>"),
    dashboard.button( "s", "  JTD Sync" , ":split | resize 10 | terminal jtd sync dob9601/dotfiles nvim<CR>i"),
    dashboard.button( "i", "  JTD Install" , ":split | resize 10 | terminal jtd install dob9601/dotfiles nvim<CR>i"),
    dashboard.button( "c", "  Config" , ":e $MYVIMRC<CR>"),
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
    \ 'typescript': [],
    \ 'typescriptreact': [],
    \ 'javascript': [],
    \ 'javascriptreact': []
    \}

"------------------ Indent Line ----------------- 

lua << EOF
require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    filetype_exclude = {"alpha"},
    char = "▏"
}
EOF

"------------------- Telescope ------------------ 

nnoremap <A-p> :Telescope<CR>
nnoremap <A-f> :Telescope live_grep<CR>
nnoremap <silent> <C-p> :Telescope find_files<CR>

lua << EOF
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local custom_actions = {}

function custom_actions.send_selected_to_qflist(prompt_bufnr)
    actions.send_selected_to_qflist(prompt_bufnr)
    actions.open_qflist()
end

require('telescope').setup {
    defaults = {
        prompt_prefix=" ",
        file_ignore_patterns = { 'node_modules', '__pycache__', '**/migrations', 'staticfiles', 'env', 'target' },
        initial_mode = 'insert',
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<C-t>"] = trouble.open_with_trouble,
                ["<C-w>"] = custom_actions.send_selected_to_qflist,
            },
            n = {
                ["<C-t>"] = trouble.open_with_trouble,
                ["<C-w>"] = custom_actions.send_selected_to_qflist,
            },
        }
    },
    pickers = {
        find_files = {
            theme = "ivy"
        },
        live_grep = {
            theme = "ivy"
        },
        oldfiles = {
            theme = "ivy"
        },
        lsp_references = {
            theme = "ivy",
            layout_config = {
                height = 10
            }
        },
        lsp_code_actions = {
            theme = "cursor"
        },
        lsp_range_code_actions = {
            theme = "cursor"
        },
        lsp_implementations = {
            theme = "ivy",
            layout_config = {
                height = 10
            }
        },
        lsp_definitions = {
            theme = "cursor",
        },
        lsp_type_definitions = {
            theme = "cursor"
        },
    }
}
EOF

"-------------------- Lualine ------------------- 

lua << EOF
require('lualine').setup({
    options = {
        theme = 'auto',
        disabled_filetypes = {'alpha'}
    },

    sections = {
        lualine_a = {'mode'},
        lualine_b = {
            {
                'branch',
                icon = ''
            },
            { 'diagnostics', sources = {'nvim_lsp', 'nvim_diagnostic', 'ale'} },
            {
                'diff',
                symbols = {added = ' ', modified = ' ', removed = ' '},
            }
        },
        lualine_c = {
            'require("lsp-status").status()',
            'filename'
        },
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
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "javascriptreact" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
      enable = false,
  }
}
EOF
