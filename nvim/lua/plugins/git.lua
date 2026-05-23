return {

	-- Signes git dans la signcolumn + hunks navigation
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				-- Navigation entre hunks
				map("]h", gs.next_hunk, "Hunk suivant")
				map("[h", gs.prev_hunk, "Hunk précédent")

				-- Actions sur les hunks
				map("<leader>hs", gs.stage_hunk, "Stage hunk")
				map("<leader>hr", gs.reset_hunk, "Reset hunk")
				map("<leader>hS", gs.stage_buffer, "Stage buffer entier")
				map("<leader>hu", gs.undo_stage_hunk, "Unstage hunk")
				map("<leader>hp", gs.preview_hunk, "Preview hunk")

				-- Blame
				map("<leader>hb", function()
					gs.blame_line({ full = true })
				end, "Blame ligne")
				map("<leader>hB", gs.toggle_current_line_blame, "Toggle blame inline")

				-- Diff
				map("<leader>hd", gs.diffthis, "Diff fichier")
			end,
		},
	},

	-- Lazygit dans un float
	{
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},

	-- Diff avancé entre fichiers / branches
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Historique fichier" },
			{ "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diffview close" },
		},
		opts = {},
	},
}
