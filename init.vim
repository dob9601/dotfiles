if &compatible
    set nocompatible               " Be iMproved
endif

set guifont=Delugia:h11

if exists("g:neovide")
  let g:neovide_cursor_vfx_mode = "railgun"
  let g:neovide_fullscreen=v:true
endif

call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/plenary.nvim' " Misc lua utils

" Language server
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'williamboman/mason.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'onsails/lspkind.nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'honza/vim-snippets'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'folke/trouble.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'stevearc/dressing.nvim'

" Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'lukas-reineke/cmp-rg'
Plug 'hrsh7th/nvim-cmp'
Plug 'ray-x/cmp-treesitter' " Treesitter source
Plug 'Saecki/crates.nvim' " Crates.io source
Plug 'hrsh7th/cmp-emoji' " Emoji source
Plug 'lvimuser/lsp-inlayhints.nvim' " Inlay hints

" Better UI stuff
Plug 'folke/noice.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'goolord/alpha-nvim'
Plug 'moll/vim-bbye'
Plug 'folke/zen-mode.nvim' " Zen mode
Plug 'folke/twilight.nvim' " Focus
Plug 'luukvbaal/stabilize.nvim' " Don't shift windows when opening other panes
Plug 'hoob3rt/lualine.nvim' " Statusbar
Plug 'kshenoy/vim-signature' " Marks in gutter
Plug 'akinsho/toggleterm.nvim' " Better terminal
Plug 'ryanoasis/vim-devicons' " Icons
Plug 'kyazdani42/nvim-web-devicons' " Icons
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'} " File browser
Plug 'lukas-reineke/indent-blankline.nvim' " Indent guides

" Colourscheme/highlights
Plug 'rebelot/kanagawa.nvim'
Plug 'mechatroner/rainbow_csv'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'folke/todo-comments.nvim' " Todo highlighting

" Navigation
Plug 'deris/vim-shot-f' 
Plug 'ggandor/leap.nvim'
Plug 'wellle/targets.vim'

" Git wrappers
Plug 'tpope/vim-fugitive' " General wrapper
Plug 'airblade/vim-gitgutter' " Show changes in gutter
Plug 'rhysd/git-messenger.vim' " Blame for current line
Plug 'rhysd/conflict-marker.vim' " Merge conflicts
Plug 'pwntester/octo.nvim' " GitHub
Plug 'sindrets/diffview.nvim' " Better diff viewing
Plug 'akinsho/bufferline.nvim' " Better top bar

" Discord
Plug 'andweeb/presence.nvim'

" Bracket closing
Plug 'windwp/nvim-autopairs'

" Languages
Plug 'maxmellon/vim-jsx-pretty' " better JSX support
Plug 'nvim-neorg/neorg' " Neorg
Plug 'jbyuki/venn.nvim' " ASCII Diagrams

" ???
Plug 'alec-gibson/nvim-tetris'
Plug 'seandewar/nvimesweeper'

" Infer indents
Plug 'tpope/vim-sleuth'
Plug 'Vimjas/vim-python-pep8-indent'

" Commenting shortcuts
Plug 'preservim/nerdcommenter'

" Telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-project.nvim'

" UNIX Helper
Plug 'tpope/vim-eunuch'

" Tagbar
Plug 'preservim/tagbar'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Treesitter synax highlighting
Plug 'nvim-treesitter/nvim-treesitter-refactor' " Treesitter-based navigation
Plug 'nvim-treesitter/nvim-treesitter-context' " Show current context

call plug#end()

" ----------------------- Vim ----------------------
filetype plugin indent on
syntax enable

set splitbelow
set splitright

set shortmess+=A

set updatetime=300

" Show find and replace as it happens. 
set inccommand=nosplit
"
" Enable mouse support
set mouse=a

set wildignore +=*/staticfiles/*,*/node_modules/*,*/env/*

set nowrap " Disable text-wrap
set number " Show line numbers

set signcolumn=yes:2

noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

tnoremap <Esc> <C-\><C-n> " Change mapping to make terminal easier to exit

set tabstop=4 shiftwidth=4 expandtab

set cursorline " Make cursor easier to find

" Make the delete button not yank
nnoremap <silent> <del> "_x
nnoremap <silent> x "_x

set fillchars+=diff:╱

set timeoutlen=500

set scrolloff=10

nnoremap <silent> <Up>    :resize -2<CR>
nnoremap <silent> <Down>  :resize +2<CR>
nnoremap <silent> <Left>  :vertical resize -2<CR>
nnoremap <silent> <Right> :vertical resize +2<CR>

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

lua << EOF
vim.opt.laststatus = 3
vim.opt.fillchars:append({
    horiz = '━',
    horizup = '┻',
    horizdown = '┳',
    vert = '┃',
    vertleft = '┨',
    vertright = '┣',
    verthoriz = '╋',
})
require("kanagawa").setup({
    globalStatus = true,
    dimInactive = true,
    ...
})
vim.cmd("colorscheme kanagawa")

require("lsp-colors").setup()
require('nvim-autopairs').setup()
require("noice").setup({
  lsp = {
    signature = {
      enabled = false
    }
  }
})
EOF

" colorscheme kanagawa " sonokai " tokyonight

" Conceal the tildes at the end of a buffer, makes start page look nicer
highlight EndOfBuffer guifg=bg

" -----------------  Colorizer   -----------------
lua require'colorizer'.setup()

" -----------------     Norg     -----------------
lua << EOF
require('neorg').setup {
  load = {
      ["core.defaults"] = {},
      ["core.norg.concealer"] = {},
      ["core.integrations.nvim-cmp"] = {},
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

nnoremap <silent><Leader>x :TSContextToggle<CR>
"
" -----------------     Leap     -----------------
lua require('leap').add_default_mappings()

" -----------------   Zen mode   -----------------
lua << EOF
require("zen-mode").setup({})
EOF

" -----------------      LSP     -----------------
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

highlight! PmenuSel guibg=#282C34
highlight! Pmenu guifg=#C5CDD9 guibg=#22252A

highlight! CmpItemAbbrDeprecated guifg=#7E8294
highlight! CmpItemAbbrMatch guifg=#82AAFF
highlight! CmpItemAbbrMatchFuzzy guifg=#82AAFF
highlight! CmpItemMenu guifg=#C792EA

highlight! CmpItemKindField guifg=#EED8DA guibg=#B5585F
highlight! CmpItemKindProperty guifg=#EED8DA guibg=#B5585F
highlight! CmpItemKindEvent guifg=#EED8DA guibg=#B5585F

highlight! CmpItemKindText guifg=#31393C guibg=#9FBD73
highlight! CmpItemKindEnum guifg=#31393C guibg=#9FBD73
highlight! CmpItemKindKeyword guifg=#31393C guibg=#9FBD73

highlight! CmpItemKindConstant guifg=#FFE082 guibg=#D4BB6C
highlight! CmpItemKindConstructor guifg=#FFE082 guibg=#D4BB6C
highlight! CmpItemKindReference guifg=#FFE082 guibg=#D4BB6C

highlight! CmpItemKindFunction guifg=#EADFF0 guibg=#A377BF
highlight! CmpItemKindStruct guifg=#EADFF0 guibg=#A377BF
highlight! CmpItemKindClass guifg=#EADFF0 guibg=#A377BF
highlight! CmpItemKindModule guifg=#EADFF0 guibg=#A377BF
highlight! CmpItemKindOperator guifg=#EADFF0 guibg=#A377BF

highlight! CmpItemKindVariable guifg=#C5CDD9 guibg=#7E8294
highlight! CmpItemKindFile guifg=#C5CDD9 guibg=#7E8294

highlight! CmpItemKindUnit guifg=#F5EBD9 guibg=#D4A959
highlight! CmpItemKindSnippet guifg=#F5EBD9 guibg=#D4A959
highlight! CmpItemKindFolder guifg=#F5EBD9 guibg=#D4A959

highlight! CmpItemKindMethod guifg=#DDE5F5 guibg=#6C8ED4
highlight! CmpItemKindValue guifg=#DDE5F5 guibg=#6C8ED4
highlight! CmpItemKindEnumMember guifg=#DDE5F5 guibg=#6C8ED4

highlight! CmpItemKindInterface guifg=#D8EEEB guibg=#58B5A8
highlight! CmpItemKindColor guifg=#D8EEEB guibg=#58B5A8
highlight! CmpItemKindTypeParameter guifg=#D8EEEB guibg=#58B5A8

nnoremap <silent> <F5> :LspRestart<CR>

set completeopt=menu,menuone,noselect

lua << EOF
require("lsp_signature").setup({
    doc_lines = 0,
    toggle_key = "<A-g>",
    zindex = 1
})

local lsp_status = require("lsp-status")
lsp_status.config({
    diagnostics = false,
    show_filename = true,
    current_function = true,
    status_symbol = ""
})
lsp_status.register_progress()

-- CMP

require("luasnip.loaders.from_snipmate").lazy_load()

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require('cmp')
require('crates').setup()


cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    completion = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
    },
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. strings[1] .. " "

      if strings[2] ~= nil then
        kind.menu = "(" .. strings[2] .. ")"
      else
        kind.menu = "(N/A)"
      end

      local source = ({
        buffer = "[Buffer]",
        rg = "[RG]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
      })[entry.source.name]

      if source ~= nil then
        kind.menu = kind.menu .. " " .. source
      end

      return kind
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'crates' },
    { name = 'luasnip' },
    { name = 'path' },
  }, {
    { name = 'treesitter' },
  }, {
    { name = 'buffer' },
  }, {
    { name = 'rg' },
    { name = 'emoji' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'treesitter' },
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
    { name = 'treesitter' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

require("lsp-inlayhints").setup()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require("lsp-inlayhints").on_attach(client, bufnr)

    lsp_status.on_attach(client)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>c', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)
end

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())


require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers {
  function (server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
  end,

  ["yamlls"] = function ()
    require("lspconfig").yamlls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
          yaml = {
              schemas = {
                  ["https://raw.githubusercontent.com/dob9601/jointhedots/fixup-schema/src/dotfile_schema.json"] = "/jtd.yaml"
              }
          }
      }
    }
  end,

  ["rust_analyzer"] = function ()
    require("lspconfig").rust_analyzer.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy"
          },
          assist = {
            importGranularity = "module",
            importPrefix = "self",
          },
          cargo = {
            loadOutDirsFromCheck = true
          },
          procMacro = {
            enable = true
          },
          diagnostics = {
            experimental = {
                enable = true
            }
          }
        }
      }
    }
  end,

  ["pylsp"] = function () 
    require("lspconfig").pylsp.setup {
      on_attach = on_attach,
      settings = {
        pylsp = {
            plugins = {
                pycodestyle = { enabled = false },
                yapf = { enabled = false },
            }
        }
      }
    }
  end
}

require("trouble").setup {
  auto_open = true,
  auto_preview = false,
  auto_close = false,
  height = 5,
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
nnoremap <silent>gb :BufferLineCycleNext<CR>
nnoremap <silent>gB :BufferLineCyclePrev<CR>

lua << EOF
require("bufferline").setup {
  options = {
      diagnostics = "nvim_lsp",
      separator_style = "slant",
      always_show_bufferline = true,
      close_command = "Bdelete %d",
      offsets = {
          {filetype = "CHADTree", text = "File Explorer", text_align = "center"}
      },
      groups = {
          options = {
              toggle_hidden_on_enter = true
          },
          items = {
              {
                  name = "Tests",
                  icon = "",
                  matcher = function(buf)
                      return buf.filename:match('%_test') or buf.filename:match('%_spec')
                  end,
              },
              {
                  name = "Dotfiles",
                  icon = "",
                  matcher = function(buf)
                      return buf.filename:sub(1, 1) == '.'
                  end,
              }
          }
      }
  },
}
EOF

" --------------------- Notify ---------------------

lua << EOF

local notify = require("notify")

notify.setup({
max_width = 100,
top_down = false,
})

local spinner_frames = { "◜", "◠", "◝", "◞", "◡", "◟" }
EOF

" -------------------- CHADTree --------------------
nnoremap <silent> <A-c> :CHADopen<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == "CHADTree") | q | endif

lua << EOF
local chadtree_settings = {
  theme = {
      text_colour_set = "nerdtree_syntax_dark"
  }
}
vim.api.nvim_set_var("chadtree_settings", chadtree_settings)
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
function toggle_venn()
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
vim.api.nvim_set_keymap('n', '<leader>v', ":lua toggle_venn()<CR>", { noremap = true, silent = true })
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
  dashboard.button( "t", "  Terminal" , ":terminal<CR>"),
  dashboard.button( "u", "ﮮ  Update Plugins" , ":PlugUpdate<CR>"),
  dashboard.button( "n", "ﴬ  Notes" , ":Neorg workspace home<CR>"),
  dashboard.button( "b", "  Browse Files" , ":Telescope file_browser<cr>"),
  dashboard.button( "p", "ﴬ  Projects" , ":Telescope project<cr>"),
  dashboard.button( "c", "  Config" , ":e $MYVIMRC<CR>"),
  dashboard.button( "q", "  Quit", ":qa<CR>"),
}

local fortune = require("alpha.fortune") 
dashboard.section.footer.val = fortune()

alpha.setup(dashboard.opts)
EOF

nnoremap <silent> <C-w>n :vsplit <bar> Alpha<CR>
nnoremap <silent> <C-w>t :tabnew <bar> Alpha<CR>

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

nnoremap <silent> <A-t> :Telescope treesitter<CR>
nnoremap <silent> <A-p> :Telescope<CR>
nnoremap <silent> <A-f> :Telescope live_grep<CR>
nnoremap <silent> <C-p> :Telescope find_files<CR>
nnoremap <silent> <leader>p :Telescope project<CR>

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

require("telescope").load_extension("file_browser")
require("telescope").load_extension("project")
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
        lualine_x = {{
          require("noice").api.statusline.mode.get,
          cond = require("noice").api.statusline.mode.has,
          color = { fg = "#ff9e64" },
        }, 'encoding', 'fileformat', 'filetype'},
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

"------------------ Toggleterm ---------------------

lua << EOF
require("toggleterm").setup {
    open_mapping = [[<c-\>]],
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
"
" -------------- Treesitter Refactor ----------
lua <<EOF
require'nvim-treesitter.configs'.setup {
  refactor = {
    highlight_definitions = {
      enable = true,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = true,
    },
  },
  navigation = {
    enable = false,
    keymaps = {
      goto_definition = "gd",
    },
  },
}
EOF
highlight! TSDefinitionUsage cterm=underline guibg=#49443c gui=underline 
highlight! TSDefinition cterm=underline guibg=#49443c gui=underline 

highlight! link LspInlayHint Comment
