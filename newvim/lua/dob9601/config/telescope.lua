local actions = require("telescope.actions")
local function send_selected_to_qflist(prompt_bufnr)
    actions.send_selected_to_qflist(prompt_bufnr)
    actions.open_qflist()
end

require("telescope").setup({
    defaults = {
        prompt_prefix = " ",
        file_ignore_patterns = { "node_modules", "__pycache__", "**/migrations", "staticfiles", "env", "target" },
        initial_mode = "insert",
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                -- ["<C-t>"] = trouble.open_with_trouble,
                ["<C-w>"] = send_selected_to_qflist,
            },
            n = {
                -- ["<C-t>"] = trouble.open_with_trouble,
                ["<C-w>"] = send_selected_to_qflist,
            },
        },
    },
    pickers = {
        find_files = {
            theme = "ivy",
        },
        live_grep = {
            theme = "ivy",
        },
        oldfiles = {
            theme = "ivy",
        },
    },
    extensions = {
        command_palette = {
            { "File",
                { "Change working directory to current file's directory", "<cmd>cd %:p:h<CR>" }
            },
            { "LSP",
                { "Format", "<cmd>lua vim.lsp.buf.format { async = true }<CR>" },
                { "Code Actions", "<cmd>lua vim.lsp.buf.code_action()<CR>" },
                { "Go to References", "<cmd>lua require(\"telescope.builtin\").lsp_references()<CR>" },
            },
        }
    }
})

require("telescope").load_extension("command_palette")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("project")

vim.api.nvim_set_keymap('n', '<A-p>', '<cmd>Telescope<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-f>', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-f>', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope command_palette<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', '<cmd>Telescope project display_type=full theme=ivy<CR>',
    { noremap = true, silent = true })
