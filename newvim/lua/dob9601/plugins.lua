-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Language server
	use("neovim/nvim-lspconfig")
	use({
		"williamboman/mason.nvim",
		requires = {
			"williamboman/mason-lspconfig.nvim",
			"lvimuser/lsp-inlayhints.nvim",
			"jose-elias-alvarez/null-ls.nvim",
			"jayp0521/mason-null-ls.nvim",
		},
		config = function()
			require("dob9601.config.lsp")
		end,
		after = { "nvim-lspconfig" },
	})

	use({
		"smjonas/live-command.nvim",
		config = function()
			require("live-command").setup({
				commands = {
					Norm = { cmd = "norm" },
				},
			})
		end,
	})

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				use_diagnostic_signs = true,
				auto_open = true,
				height = 7,
			})
		end,
	})
	use({
		"folke/lsp-colors.nvim",
		config = function()
			require("lsp-colors").setup()
		end,
	})

	-- Better LSP UI
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			require("lspsaga").setup()
		end,
		requires = { { "nvim-tree/nvim-web-devicons" } },
	})

	-- Bracket closing
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- Autocompletion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"ray-x/cmp-treesitter",
			"hrsh7th/cmp-cmdline",
			"lukas-reineke/cmp-rg",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"Saecki/crates.nvim",
			"hrsh7th/cmp-emoji",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"honza/vim-snippets",
			"onsails/lspkind.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("dob9601.config.cmp")
		end,
		after = { "nvim-autopairs" },
	})

	use({
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				render = "minimal",
				max_width = 70,
				max_height = 4,
				timeout = 3,
			})
		end,
	})

	-- Packer
	use({
		"folke/noice.nvim",
		config = function()
			require("noice").setup({
				views = {
					cmdline_popup = {
						border = {
							style = "none",
							padding = { 1, 1 },
						},
						filter_options = {},
						win_options = {
							winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
						},
					},
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
				},
			})
		end,
		requires = {
			"MunifTanjim/nui.nvim",
		},
		after = { "nvim-notify" },
	})
	use({
		"goolord/alpha-nvim",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {
				"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⡤⡴⠶⠲⠚⠊⣀⣤⣤⣴⡶⡶⠖⠢⠀⡀⠀⢀⢀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠤⠴⠖⠛⠋⡉⢄⣠⣤⡶⡲⠿⡛⠛⠑⠉⡀⠠⢀⣀⣦⣴⣶⠻⡟⠟⠟⠋⠋⢁⣀⣤⢶⢶⡶⠷⢶⠦⠤⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣤⣔⣐⢔⡐⠔⡠⢑⠈⢄⠄⡠⠀⢄⠈⠄⢄⠡⠈⠄⠒⠛⠛⠛⠌⠚⡀⢉⢀⣴⢴⡶⠻⣛⣫⢍⠗⠊⠋⡉⢀⠐⠀⠊⢐⡠⢟⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣞⠳⠲⡬⢎⡵⣩⣋⢳⢓⡝⡲⠮⢴⢕⢦⣑⢕⡤⣑⢌⡢⡑⢌⠰⡈⡄⢅⠔⡠⢂⠄⢄⢉⢉⠉⠄⠄⠂⠁⢂⢐⡠⡥⢲⢋⢕⠨⡂⢜⡆⠀⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣺⠎⡨⠎⠨⡓⡱⡣⣎⢧⠳⣜⢕⡝⢦⡓⣕⢕⢕⢎⢮⠱⣍⢭⡹⡩⡺⣘⢖⢕⢖⡲⡓⡞⡲⣕⢛⠶⡲⣫⢻⢍⡗⡵⣪⢣⢕⢕⠕⡌⢂⢿⠀⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⢿⠀⡞⡤⡰⣡⢳⡝⣮⢪⢗⡵⣣⢫⢞⡜⡮⣪⢳⡱⣣⠫⠒⣑⠕⣝⢜⢎⢮⢣⢧⡹⡪⡞⡵⣪⣫⡫⣳⢕⢯⢮⡫⣞⢼⡱⣣⢣⢓⠜⡄⣹⡄⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⠀⠀⢼⡇⢪⢜⣽⣹⣻⢼⡳⣵⣫⡳⣝⢮⡳⣝⢮⡳⣕⢧⡫⣮⢅⡠⠜⡔⣧⢫⡎⡷⣱⢇⡟⣼⡹⣎⢷⢜⣗⢽⡹⣳⡝⣾⡱⣏⡞⡵⡱⡕⢕⢌⢌⡇⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠂⡵⣱⢗⡕⣿⢼⡳⣵⢣⣟⢼⣣⢟⡼⣣⢟⡼⣣⢟⡼⣣⢟⢽⡯⣞⢵⡝⣮⢳⡝⣮⢳⣝⢮⡳⡯⣞⡽⣝⣮⡻⣼⢝⣮⡫⣞⢕⢝⢔⢅⠂⣿⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⠀⢐⡿⢑⢎⢾⣝⡭⣗⣝⢷⡹⣧⢫⣗⢽⣪⢟⡼⣳⢽⡪⡷⣝⢮⡻⣺⡗⣽⡣⣟⡼⣳⢝⡮⣗⡽⣳⣝⢯⣞⡽⣺⢎⡿⣪⢷⣣⢟⡼⡱⡣⡣⢊⢕⢜⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⠀⢨⣟⢨⢎⡷⣵⡃⡧⡻⣮⢳⣝⢧⡻⣎⢷⡝⡾⣵⡫⣾⡹⣮⣫⢗⣽⢺⣕⢿⢜⢷⣝⣝⢾⢕⣟⢮⡞⣷⢝⡾⣝⡽⣝⣗⢯⡺⣧⡋⢊⡵⣃⠪⡢⣹⡄⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⠀⢼⡇⢮⡪⣷⣹⢆⡧⣟⢮⣳⣝⢮⢷⣝⢮⡻⡺⣎⢷⢵⣫⢞⣼⡃⣿⢸⡧⣫⢯⡳⣮⡺⡳⡯⣞⡽⣺⡳⣏⢿⣪⢟⣮⡻⡐⢜⣮⡣⡶⡱⡕⡝⢔⠼⡆⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⠀⣾⠣⣪⢞⢮⣞⡵⡶⣝⢧⡳⣝⡳⣳⢝⣮⣫⡻⣮⢳⢯⡺⡧⣻⡌⣿⢸⡝⣷⡹⣞⢵⣝⢯⢾⢵⡫⡷⣽⢝⡷⣝⢯⣞⡽⣺⢯⢞⡮⣳⢝⡪⣪⢣⢚⡇⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⠀⣾⠇⢵⡹⢓⡠⡐⠀⠉⢾⡹⣮⣫⢗⢯⣞⢼⡣⣯⢳⢯⡺⣝⢮⢧⣛⣼⡫⣞⡵⣫⢗⣝⢷⣹⡳⣝⡯⣞⡽⣞⡽⣳⣝⢾⣝⢗⣟⢮⡳⣝⢮⡱⡕⡕⡧⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⢀⣿⠆⢀⠇⢅⠡⠊⠴⡁⠔⣟⠮⠞⣝⢧⢯⡺⣝⣮⣫⢗⣻⡚⠗⢉⠊⠊⢯⡮⡻⣎⢿⡜⡷⣵⡫⡷⡽⣮⡻⣮⢻⡮⣳⢯⡺⣯⢞⣽⡪⣗⣕⡳⣪⢚⣗⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⠠⣿⢍⡻⡄⢅⢉⢂⠅⡐⢁⣯⣃⠠⣸⣏⢷⣝⢞⠎⡈⢻⡜⢁⠌⠢⡡⡂⡆⠽⣝⣞⡳⣝⢾⣪⡻⣞⢽⢮⢷⣝⢷⣝⢷⣫⢟⣮⢗⡷⣝⢮⢮⡺⣕⢝⡮⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⢘⡷⡕⣝⢷⣤⣁⣁⢔⣨⡴⡷⣝⢟⡵⣝⣞⢮⡻⣣⣤⢟⠄⡅⠴⡐⠰⠑⡘⡄⣿⡜⢁⠉⣷⢝⡮⣯⣛⢷⣫⣞⢷⣝⢷⣝⢯⢾⣝⡮⣯⡳⣫⢞⡮⠓⡁⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⠀⡉⠚⠪⠳⢽⣝⢯⢿⢵⡻⣮⣫⡻⣺⢵⡝⡷⣝⢧⡯⣫⣧⠐⠤⡂⢝⠐⢕⣨⢷⣝⢮⢶⣫⡻⣺⢵⣫⢟⣮⡳⣯⢞⡷⣝⣯⣳⣝⢾⡵⡫⠗⢉⢄⢊⠂⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⠐⡜⢦⢕⣄⣀⠀⢨⠁⡉⠓⠑⠓⠝⠷⠫⡾⣝⣞⢷⡹⡧⣯⡻⣶⣥⣦⣭⢾⡝⣾⡪⣷⣫⣞⡽⣳⣝⣗⢿⣪⣟⢮⣟⣽⡺⣮⠾⠍⠓⢉⢀⠎⢔⠢⠁⠌⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠈⠂⠜⢐⠢⡰⢡⡙⡑⢕⠢⡪⠰⡡⢄⡐⡠⡀⠠⠀⠉⠉⠊⠊⠓⠳⠵⠳⢝⢗⣟⣮⡳⣗⡵⣞⡽⣺⢮⣳⡻⣮⡫⠷⠝⢊⠉⡁⢐⡨⢌⢆⠣⡑⠁⠄⠁⢀⠀⠂⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⢈⠀⠡⢀⠡⠂⠢⡈⠌⠢⠑⢌⠊⢔⠐⢌⠔⡉⡊⢕⠑⡕⢌⠆⢔⠤⡠⣀⢄⢀⠀⡀⠠⠀⠌⠈⢈⠅⣕⠇⠀⠄⡀⢂⢔⠤⣊⠒⠕⢌⠂⢂⠁⠠⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⡀⠈⠠⠀⡁⠊⠠⠁⠄⠡⠈⠂⠔⢈⠐⡡⢈⠢⢂⠑⡂⢒⠔⠤⠡⡑⠩⡘⠑⠕⠪⡒⠲⡘⡔⡏⠀⠄⡸⠑⡌⠢⡈⠊⠐⠠⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠐⠀⠂⠐⠀⠁⠐⠀⠀⠂⠠⠀⠂⠠⠁⠈⠄⠂⡈⠂⡈⠐⠈⡈⠈⠄⠈⠐⠈⠈⠈⠐⠈⠀⡁⠐⠀⡀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
				"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠀⠀⠀⠀⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			}

			dashboard.section.buttons.val = {
				dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
				dashboard.button("c", "  Config", ":e $MYVIMRC<CR>"),
				dashboard.button("p", "ﴬ  Projects", "<cmd>Telescope project display_type=full theme=ivy<CR>"),
				dashboard.button("q", "  Quit", ":qa<CR>"),
			}
			local fortune = require("alpha.fortune")
			dashboard.section.footer.val = fortune()

			dashboard.section.terminal.command = "echo 'hi'"

			alpha.setup(dashboard.opts)
		end,
	})
	use({
		"moll/vim-bbye",
		config = function()
			vim.api.nvim_set_keymap("n", "<A-b>d", ":Bdelete<CR>", { noremap = true, silent = true })
		end,
	})
	use({
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup({})
			vim.api.nvim_set_keymap("n", "<A-t>", "<cmd>Twilight<CR>", { noremap = true, silent = true })
		end,
	})
	use("luukvbaal/stabilize.nvim") -- Don't shift windows when opening other panes DEPRECATED IN v0.9.0 of nvim
	use({
		"hoob3rt/lualine.nvim", -- Statusbar
		config = function()
			require("dob9601.config.lualine")
		end,
		after = { "noice.nvim" },
	})
	-- Marks in gutter
	use({
		"chentoast/marks.nvim",
		config = function()
			require("marks").setup()
		end,
	})

	use("ryanoasis/vim-devicons") -- Icons
	use("kyazdani42/nvim-web-devicons") -- Icons

	-- Indent guides
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				space_char_blankline = " ",
				show_current_context = true,
				show_current_context_start = true,
				filetype_exclude = { "alpha" },
				char = "▏",
			})
		end,
	})

	-- Colourscheme/highlights
	use({
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				globalStatus = true,
				dimInactive = true,
			})

			vim.cmd("colorscheme kanagawa")
		end,
	})
	use({
		"mechatroner/rainbow_csv",
		ft = { "csv", "tsv" },
	})
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
		ft = { "css", "html", "js", "ts", "jsx", "tsx" },
	})
	use("folke/todo-comments.nvim") -- Todo highlighting, NEEDS CONFIGURING

	-- Navigation
	use("deris/vim-shot-f")
	use({
		"ggandor/leap.nvim",
		config = function()
			vim.api.nvim_set_keymap("n", "r", "<Plug>(leap-forward-to)", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "R", "<Plug>(leap-backward-to)", { noremap = true, silent = true })
		end,
	})
	use("wellle/targets.vim")

	use("tpope/vim-surround")

	-- Git wrappers
	use({
		"tpope/vim-fugitive",
		config = function()
			vim.api.nvim_set_keymap("n", "ga", ":Git add %<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "gk", ":Git commit<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "gs", ":Git status<CR>", { noremap = true, silent = true })
		end,
	}) -- General wrapper
	--
	-- Merge conflicts
	use({
		"rhysd/conflict-marker.vim",
		config = function()
			vim.cmd([[            
                highlight ConflictMarkerBegin guibg=#2f7366
                highlight ConflictMarkerOurs guibg=#2e5049
                highlight ConflictMarkerTheirs guibg=#344f69
                highlight ConflictMarkerEnd guibg=#2f628e
                highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
            ]])
		end,
	})

	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
	use({
		"akinsho/bufferline.nvim",
		config = function()
			require("bufferline").setup({
				options = {
					diagnostics = "nvim_lsp",
					separator_style = "slant",
					always_show_bufferline = true,
					close_command = "Bdelete %d",
					groups = {
						options = {
							toggle_hidden_on_enter = true,
						},
					},
				},
			})
		end,
	}) -- Better top bar

	-- Discord
	-- use("andweeb/presence.nvim")

	-- Languages
	--  use 'maxmellon/vim-jsx-pretty' " better JSX support
	use("jbyuki/venn.nvim") -- ASCII Diagrams

	-- Infer indents
	use("tpope/vim-sleuth")
	-- Commenting shortcuts
	--   use 'preservim/nerdcommenter'
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-project.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"LinArcX/telescope-command-palette.nvim",
		},
		config = function()
			require("dob9601.config.telescope")
		end,
	})

	-- Tagbar
	use({
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup({
				-- optionally use on_attach to set keymaps when aerial has attached to a buffer
				on_attach = function(bufnr)
					vim.keymap.set("n", "<A-[>", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "<A-]>", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
				attach_mode = "global",
			})
			-- You probably also want to set a keymap to toggle aerial
			vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle! right<CR>")
		end,
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-refactor",
		},
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = "all",
				ignore_install = {},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
				},
				refactor = {
					highlight_definitions = {
						enable = true,
						clear_on_cursor_move = false,
					},
				},
				navigation = {
					enable = false,
				},
			})

			vim.cmd([[
                highlight! TSDefinitionUsage cterm=underline guibg=#49443c gui=underline 
                highlight! TSDefinition cterm=underline guibg=#49443c gui=underline 
            ]])
		end,
	})
end)
