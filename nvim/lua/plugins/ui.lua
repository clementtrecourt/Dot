return {

	-- ── Thème Catppuccin ─────────────────────────────────────
	-- 1. LE THÈME
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- Tu peux changer en latte, frappe, macchiato
				integrations = {
					lualine = true,
					cmp = true,
					treesitter = true,
					telescope = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- 2. LA BARRE DE STATUT (Lualine)
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin", -- Maintenant ça marchera à 100%
					globalstatus = true,
				},
			})
		end,
	},
	-- ── Bufferline ───────────────────────────────────────────
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				mode = "buffers",
				separator_style = "slant",
				show_buffer_close_icons = true,
				show_close_icon = false,
				diagnostics = "nvim_lsp", -- icônes erreurs/warnings sur les tabs
				diagnostics_indicator = function(_, _, diag)
					local icons = { error = " ", warning = " " }
					local ret = (diag.error and icons.error .. diag.error .. " " or "")
						.. (diag.warning and icons.warning .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "NvimTree",
						text = "Explorer",
						highlight = "Directory",
						separator = true,
					},
				},
			},
		},
	},

	-- ── Indentation visuelle ─────────────────────────────────
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		main = "ibl",
		opts = {
			indent = { char = "│" },
			scope = { enabled = true },
			exclude = {
				filetypes = { "help", "dashboard", "NvimTree", "lazy", "mason" },
			},
		},
	},

	-- ── Dashboard ────────────────────────────────────────────
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("dashboard").setup({
				theme = "doom",
				config = {
					header = {
						"",
						"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ",
						"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ",
						"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ",
						"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ",
						"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ",
						"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ",
						"",
					},
					center = {
						{
							icon = "  ",
							desc = "Nouveau fichier          ",
							key = "n",
							action = "enew",
						},
						{
							icon = "  ",
							desc = "Fichiers récents         ",
							key = "r",
							action = "Telescope oldfiles",
						},
						{
							icon = "  ",
							desc = "Chercher fichier         ",
							key = "f",
							action = "Telescope find_files",
						},
						{
							icon = "  ",
							desc = "Grep projet              ",
							key = "g",
							action = "Telescope live_grep",
						},
						{
							icon = "  ",
							desc = "Config Neovim            ",
							key = "c",
							action = "edit ~/.config/nvim/init.lua",
						},
						{
							icon = "󰒲  ",
							desc = "Lazy                     ",
							key = "l",
							action = "Lazy",
						},
						{
							icon = "  ",
							desc = "Quitter                  ",
							key = "q",
							action = "qa",
						},
					},
				},
			})
		end,
	},

	-- ── Notifications ─────────────────────────────────────────
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		opts = {
			timeout = 2000,
			max_width = 60,
			render = "compact",
			stages = "static", -- pas d'animation (plus propre sur Wayland)
		},
		config = function(_, opts)
			local notify = require("notify")
			notify.setup(opts)
			vim.notify = notify -- remplace vim.notify par défaut
		end,
	},
}
