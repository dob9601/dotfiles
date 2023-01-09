require("mason").setup()
require("mason-lspconfig").setup()
require("lsp-inlayhints").setup()

vim.cmd([[
  highlight! link LspInlayHint Comment
]])

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    require("lsp-inlayhints").on_attach(client, bufnr)
end

require("mason-lspconfig").setup_handlers({
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,

    ["yamlls"] = function()
        require("lspconfig").yamlls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                yaml = {
                    schemas = {
                        ["https://raw.githubusercontent.com/dob9601/jointhedots/fixup-schema/src/dotfile_schema.json"] = "/jtd.yaml",
                    },
                },
            },
        })
    end,

    ["rust_analyzer"] = function()
        require("lspconfig").rust_analyzer.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                ["rust-analyzer"] = {
                    checkOnSave = {
                        command = "clippy",
                    },
                    assist = {
                        importGranularity = "module",
                        importPrefix = "self",
                    },
                    cargo = {
                        loadOutDirsFromCheck = true,
                    },
                    procMacro = {
                        enable = true,
                    },
                    diagnostics = {
                        experimental = {
                            enable = true,
                        },
                    },
                },
            },
        })
    end,

    ["pylsp"] = function()
        require("lspconfig").pylsp.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                pylsp = {
                    plugins = {
                        pycodestyle = { enabled = false },
                        yapf = { enabled = false },
                    },
                },
            },
        })
    end,

    ["sumneko_lua"] = function()
        require("lspconfig").sumneko_lua.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })
    end,
})
