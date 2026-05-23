return {

	-- Shellcheck + formatters via conform (plus maintenu que none-ls pour ça)
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		keys = {
			{
				"<leader>lf",
				function()
					require("conform").format({ async = true })
				end,
				desc = "Formater le fichier",
			},
		},
		opts = {
			formatters_by_ft = {
				sh = { "shfmt" },
				bash = { "shfmt" },
				python = { "black" },
				terraform = { "terraform_fmt" },
				yaml = {}, -- yamllint est un linter, pas un formatter
			},
			format_on_save = {
				timeout_ms = 2000,
				lsp_fallback = true,
			},
		},
	},

	-- Shellcheck via plugin dédié (plus fiable que none-ls pour ça)
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				sh = { "shellcheck" },
				bash = { "shellcheck" },
				yaml = { "yamllint" }, -- double sécurité avec none-ls
			}

			-- Déclenche le lint à l'ouverture et à la sauvegarde
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
