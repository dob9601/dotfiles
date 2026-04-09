local actions = require("telescope.actions")
local function send_selected_to_qflist(prompt_bufnr)
	actions.send_selected_to_qflist(prompt_bufnr)
	actions.open_qflist()
end

local command_center = require("command_center")
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
		command_center = {
			components = {
				command_center.component.DESC,
				command_center.component.KEYS,
			},
			sort_by = {
				command_center.component.DESC,
				command_center.component.KEYS,
			},
			auto_replace_desc_with_cmd = false,
		},
		["ui-select"] = {
			require("telescope.themes").get_ivy({
				-- even more opts
			}),
		},
	},
})

command_center.add({
	{
		desc = "Format the current buffer",
		cmd = "<cmd>lua vim.lsp.buf.format { async = true }<CR>",
	},
	{
		desc = "Code Actions",
		cmd = "<cmd>lua vim.lsp.buf.code_action()<CR>",
	},
	{
		desc = "Go to References",
		cmd = "<cmd>lua require('telescope.builtin').lsp_references()<CR>",
	},
	{
		desc = "Change working directory to current file's directory",
		cmd = "<cmd>cd %:p:h<CR>",
	},
	{
		desc = "Browse Files",
		cmd = "<cmd>Telescope file_browser<CR>",
	},
})

require("telescope").load_extension("command_center")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("project")
require("telescope").load_extension("ui-select")

vim.api.nvim_set_keymap("n", "<A-p>", "<cmd>Telescope<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-f>", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-f>", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>Telescope command_center<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>p",
	"<cmd>Telescope project display_type=full theme=ivy<CR>",
	{ noremap = true, silent = true }
)
