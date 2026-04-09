require("lualine").setup({
	options = {
		theme = "auto",
		disabled_filetypes = { "alpha" },
	},

	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			{
				"branch",
				icon = "",
			},
			{ "diagnostics", sources = { "nvim_lsp", "nvim_diagnostic", "ale" } },
			{
				"diff",
				symbols = { added = " ", modified = " ", removed = " " },
			},
		},
		lualine_c = {
			"filename",
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	extensions = { "fugitive" },
})
