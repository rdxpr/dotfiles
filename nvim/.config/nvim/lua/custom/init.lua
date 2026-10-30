-- Personal overrides extracted from the previous kickstart.nvim config.
-- Loaded from init.lua with `require 'custom'`.
--
-- Keep this file self-contained so it can be copied into a fresh base config.

-- [[ Preferences ]]

-- Nerd Font is installed and selected in the terminal.
vim.g.have_nerd_font = true

-- Relative line numbers make vertical jumps easier.
vim.o.relativenumber = true

-- Ensure true color is enabled.
vim.o.termguicolors = true

-- The base config syncs the system clipboard automatically. Keep the OS
-- clipboard independent and copy explicitly with <leader>y instead.
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    vim.o.clipboard = ''
  end,
})

-- [[ Keymaps ]]

-- Yank to the system clipboard.
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })

-- Move the current line / selection up and down.
vim.keymap.set('v', '<A-j>', ':m .+1<CR>==', { silent = true, desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ':m .-2<CR>==', { silent = true, desc = 'Move selection up' })

-- Paste without overwriting the current register.
vim.keymap.set('v', 'p', '"_dP', { silent = true, desc = 'Paste without yanking' })
vim.keymap.set('x', '<leader>p', '"_dP', { silent = true, desc = 'Paste without yanking' })

-- Move the selection up and down while keeping it selected.
vim.keymap.set('x', 'J', ":move '>+1<CR>gv-gv", { silent = true, desc = 'Move selection down' })
vim.keymap.set('x', 'K', ":move '<-2<CR>gv-gv", { silent = true, desc = 'Move selection up' })
vim.keymap.set('x', '<A-j>', ":move '>+1<CR>gv-gv", { silent = true, desc = 'Move selection down' })
vim.keymap.set('x', '<A-k>', ":move '<-2<CR>gv-gv", { silent = true, desc = 'Move selection up' })

-- Show the full diagnostic message in a floating window.
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
