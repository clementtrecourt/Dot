local opt = vim.opt

-- Apparence
opt.number         = true   -- numéros de lignes absolus
opt.relativenumber = true   -- numéros relatifs (navigation rapide)
opt.cursorline     = true   -- surligne la ligne courante
opt.signcolumn     = "yes"  -- colonne pour les signes LSP/git (évite le layout shift)
opt.colorcolumn    = "120"  -- repère visuel à 120 chars
opt.termguicolors  = true   -- couleurs 24-bit (requis pour Catppuccin)
opt.scrolloff      = 8      -- garde 8 lignes visibles autour du curseur

-- Indentation
opt.tabstop        = 2      -- 1 tab = 2 espaces (YAML friendly)
opt.shiftwidth     = 2
opt.expandtab      = true   -- tabs → espaces
opt.smartindent    = true

-- Recherche
opt.ignorecase     = true   -- recherche insensible à la casse...
opt.smartcase      = true   -- ...sauf si tu mets une majuscule
opt.hlsearch       = false  -- pas de surbrillance persistante après recherche
opt.incsearch      = true   -- surbrillance en temps réel

-- Comportement
opt.wrap           = false  -- pas de retour à la ligne automatique
opt.splitbelow     = true   -- split horizontal → en bas
opt.splitright     = true   -- split vertical → à droite
opt.swapfile       = false  -- pas de fichiers .swp
opt.backup         = false
opt.undofile       = true   -- historique undo persistant entre sessions
opt.undodir        = vim.fn.stdpath("data") .. "/undodir"
opt.updatetime     = 200    -- délai avant que CursorHold se déclenche (LSP diagnostics)
opt.timeoutlen     = 300    -- délai pour les séquences de touches

-- Clipboard
opt.clipboard      = "unnamedplus"  -- intégration clipboard système (Wayland OK)

-- Complétion
opt.completeopt    = "menu,menuone,noselect"
