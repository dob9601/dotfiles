vim.opt.splitright = true
vim.opt.splitbelow = true

-- Indents
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

-- Line numbers
vim.opt.number = true

-- How long before a partially entered command is aborted
vim.opt.timeoutlen = 500

vim.opt.fillchars = {
    diff = "╱", -- alternatives = ⣿ ░
    vert = "│",
    fold = "⠀",
    eob = " ",
    msgsep = "‾",
    foldopen = "▾",
    foldsep = "│",
    foldclose = "▸",
}

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Gutter
vim.opt.signcolumn = "yes:2"

-- Scroll offset from edge
vim.opt.scrolloff = 10

-- Highlight the line the cursor is on
vim.opt.cursorline = true

-- Make vim feel faster
vim.opt.updatetime = 50

vim.opt.shortmess = vim.opt.shortmess + "As"

vim.opt.laststatus = 3

vim.opt.termguicolors = true
