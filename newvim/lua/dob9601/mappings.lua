local opts = { noremap=true, silent=true }

-- Save with CTRL+S
vim.api.nvim_set_keymap('i', '<C-s>', '<C-O>:update<CR>', opts)
vim.api.nvim_set_keymap('v', '<C-s>', '<C-C>:update<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-s>', ':update<CR>', opts)

-- Resize windows with arrow keys
vim.api.nvim_set_keymap('n', '<Up>', ':resize +2<CR>', opts)
vim.api.nvim_set_keymap('n', '<Down>', ':resize -2<CR>', opts)
vim.api.nvim_set_keymap('n', '<Left>', ':vertical resize +2<CR>', opts)
vim.api.nvim_set_keymap('n', '<Right>', ':vertical resize -2<CR>', opts)

-- Easier mapping to escape terminals
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', opts)

-- Don't yank when using 'x' or '<del>' to delete characters
vim.api.nvim_set_keymap('n', '<del>', '"_x', opts)
vim.api.nvim_set_keymap('n', 'x', '"_x', opts)


vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)

vim.api.nvim_set_keymap('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>Lspsaga lsp_finder<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>rn', '<cmd>Lspsaga rename<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>t', '<cmd>Lspsaga term_toggle<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>c', '<cmd>Lspsaga code_action<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>o', '<cmd>Lspsaga outline<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)

vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

vim.api.nvim_set_keymap('n', '<C-b>', '<cmd>BufferLinePickClose<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-b>', '<cmd>BufferLinePick<CR>', opts)

vim.api.nvim_set_keymap('n', '<leader>cd', '<cmd>cd %:p:h<CR>:pwd<CR>', opts)
