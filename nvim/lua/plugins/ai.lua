return {
	-- 1. SUPERMAVEN : L'autocomplétion gratuite la plus rapide
	{
		"supermaven-inc/supermaven-nvim",
		event = "InsertEnter",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<Tab>", -- Accepter toute la ligne
					clear_suggestion = "<C-]>", -- Refuser la suggestion
					accept_word = "<C-j>", -- Accepter mot par mot
				},
				color = {
					suggestion_color = "#8aadf4", -- Une belle couleur Catppuccin pour les suggestions
					cterm = 244,
				},
				-- Optionnel : Ne pas activer l'IA sur certains fichiers sensibles
				condition = function()
					return not string.match(vim.fn.expand("%:p"), "secret.tf")
				end,
			})
		end,
	},

	-- 2. GP.NVIM : Chat IA (ChatGPT / Claude / Ollama)
	{
		"robitx/gp.nvim",
		keys = {
			{ "<C-g>c", "<cmd>GpChatNew<cr>", desc = "Nouveau Chat IA" },
			{ "<C-g>t", "<cmd>GpChatToggle<cr>", desc = "Ouvrir/Fermer Chat IA" },
			{ "<C-g>r", "<cmd>GpRewrite<cr>", mode = "v", desc = "Refactoriser la sélection" },
		},
		config = function()
			require("gp").setup({
				providers = {
					openai = {
						disable = false,
						endpoint = "https://api.openai.com/v1/chat/completions",
						-- Il faudra exporter ta clé dans ton terminal : export OPENAI_API_KEY="sk-..."
						secret = os.getenv("OPENAI_API_KEY"),
					},
				},
				agents = {
					{
						name = "ChatGPT4o",
						chat = true,
						command = false,
						-- modèle utilisé pour discuter :
						model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
						system_prompt = "Tu es un expert DevOps et développeur. Réponds de façon concise et donne directement le code.",
					},
					{
						name = "CodeGPT4o",
						chat = false,
						command = true,
						-- modèle utilisé quand tu lui demandes de générer du code dans ton fichier :
						model = { model = "gpt-4o", temperature = 0.8, top_p = 1 },
						system_prompt = "Tu écris du code propre, sans explications inutiles. Seulement le code.",
					},
				},
			})
		end,
	},
}
