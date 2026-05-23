local autocmd = vim.api.nvim_create_autocmd

-- Surligner brièvement le texte copié (feedback visuel)
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Retour à la dernière position connue quand on rouvre un fichier
autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Indentation 4 espaces pour Python (PEP8), 2 pour tout le reste
autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vim.opt_local.tabstop    = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- Désactiver l'auto-insertion de commentaires sur nouvelle ligne
autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})
