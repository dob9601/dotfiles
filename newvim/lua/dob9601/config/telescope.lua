require("telescope").load_extension("file_browser")
require("telescope").load_extension("project")

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
})

vim.api.nvim_set_keymap('n', '<A-p>', '<cmd>Telescope<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-f>', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', '<cmd>Telescope project display_type=full theme=ivy<CR>',
    { noremap = true, silent = true })
