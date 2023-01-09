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
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
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
    { name = 'crates' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  }, {
    { name = 'treesitter' },
  }, {
    { name = 'buffer' },
    { name = 'rg' },
  }, {
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

vim.cmd [[
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
]]
