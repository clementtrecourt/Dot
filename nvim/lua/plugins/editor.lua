return {

	-- Dépendance partagée par Telescope et d'autres plugins
	{ "nvim-lua/plenary.nvim", lazy = true },

	-- Icônes (optionnel mais propre avec une Nerd Font)
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- Détection automatique d'indentation
	{ "tpope/vim-sleuth" },

	-- Which-key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			delay = 400,
			icons = { mappings = false },
		},
	},

	-- ────────────────────────────────────────────
	-- Telescope : fuzzy finder universel
	-- ────────────────────────────────────────────
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		-- lazy.nvim charge Telescope dès qu'une de ces touches est pressée
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Fichiers" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Fichiers récents" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep projet" },
			{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep mot curseur" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Aide Neovim" },
			{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Symboles LSP" },
			{ "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Symboles LSP projet" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Commits git" },
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Branches git" },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Status git" },
		},
		cmd = "Telescope",
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
						},
					},
					sorting_strategy = "ascending",
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<Esc>"] = actions.close,
						},
					},
					file_ignore_patterns = {
						"node_modules",
						".git/",
						"*.lock",
						"__pycache__",
						".terraform/",
					},
				},
				pickers = {
					find_files = { hidden = true },
				},
			})

			pcall(telescope.load_extension, "fzf")
		end,
	},

	-- ────────────────────────────────────────────
	-- nvim-tree : explorateur de fichiers
	-- ────────────────────────────────────────────
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle explorateur" },
			{ "<leader>ef", "<cmd>NvimTreeFocus<cr>", desc = "Focus explorateur" },
		},
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			require("nvim-tree").setup({
				view = { width = 35, side = "left" },
				renderer = {
					group_empty = true,
					icons = { show = { file = true, folder = true, folder_arrow = true, git = true } },
				},
				filters = {
					dotfiles = false,
					custom = { ".git", "node_modules", "__pycache__" },
				},
				git = { enable = true, ignore = false, timeout = 400 },
				actions = { open_file = { quit_on_open = false } },
			})
		end,
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ha", desc = "Harpoon : ajouter" },
			{ "<leader>hh", desc = "Harpoon : liste" },
			{ "<leader>1", desc = "Harpoon 1" },
			{ "<leader>2", desc = "Harpoon 2" },
			{ "<leader>3", desc = "Harpoon 3" },
			{ "<leader>4", desc = "Harpoon 4" },
			{ "<leader>hn", desc = "Harpoon : suivant" },
			{ "<leader>hp", desc = "Harpoon : précédent" },
		},
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({ settings = { save_on_toggle = true, sync_on_ui_close = true } })

			local map = vim.keymap.set
			map("n", "<leader>ha", function()
				harpoon:list():add()
			end, { desc = "Harpoon : ajouter" })
			map("n", "<leader>hh", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "Harpoon : liste" })
			map("n", "<leader>1", function()
				harpoon:list():select(1)
			end, { desc = "Harpoon 1" })
			map("n", "<leader>2", function()
				harpoon:list():select(2)
			end, { desc = "Harpoon 2" })
			map("n", "<leader>3", function()
				harpoon:list():select(3)
			end, { desc = "Harpoon 3" })
			map("n", "<leader>4", function()
				harpoon:list():select(4)
			end, { desc = "Harpoon 4" })
			map("n", "<leader>hn", function()
				harpoon:list():next()
			end, { desc = "Harpoon : suivant" })
			map("n", "<leader>hp", function()
				harpoon:list():prev()
			end, { desc = "Harpoon : précédent" })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		config = function()
			-- pcall évite le crash si le plugin est en cours de téléchargement
			local status_ok, configs = pcall(require, "nvim-treesitter.configs")
			if not status_ok then
				return
			end

			configs.setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"bash",
					"terraform",
					"hcl",
					"json",
					"yaml",
					"python",
					"markdown",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	-- 2. AUTOPAIRS : Fermeture automatique des (, [, {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true, -- Utilise la configuration par défaut
	},

	-- 3. SURROUND : Manipuler les guillemets/parenthèses facilement (ex: cs"')
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = true,
	},

	-- 4. OIL : Éditer son système de fichiers comme un texte normal
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup()
			-- Appuie sur "-" pour ouvrir le dossier parent
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Ouvrir le dossier parent (Oil)" })
		end,
	},
	-- FLASH : Se déplacer instantanément n'importe où à l'écran
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			-- Ici on met "s", mais tu peux remplacer "s" par "z" si tu préfères !
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},

			-- Bonus : "S" te permet de sélectionner tout un bloc de code (Treesitter) d'un coup
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
		},
	},
}
