local map = vim.keymap.set

-- Leader key = espace (standard moderne, confortable)
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- Qualité de vie basique
map("n", "<leader>w", "<cmd>w<cr>",  { desc = "Sauvegarder" })
map("n", "<leader>q", "<cmd>q<cr>",  { desc = "Quitter" })
map("n", "<Esc>",     "<cmd>nohlsearch<cr>")  -- effacer la surbrillance de recherche

-- Navigation entre splits (sans Ctrl-W prefix)
map("n", "<C-h>", "<C-w>h", { desc = "Split gauche" })
map("n", "<C-l>", "<C-w>l", { desc = "Split droit" })
map("n", "<C-j>", "<C-w>j", { desc = "Split bas" })
map("n", "<C-k>", "<C-w>k", { desc = "Split haut" })

-- Déplacer des lignes sélectionnées (mode visuel)
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Déplacer ligne bas" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Déplacer ligne haut" })

-- Garder le curseur centré lors des sauts
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n",     "nzzzv")
map("n", "N",     "Nzzzv")

-- Coller sans écraser le registre (très utile)
map("x", "<leader>p", '"_dP', { desc = "Coller sans perdre le registre" })

-- Navigation entre buffers
map("n", "<S-l>", "<cmd>bnext<cr>",     { desc = "Buffer suivant" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Buffer précédent" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Fermer buffer" })
