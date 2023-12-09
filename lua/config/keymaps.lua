-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Space>ws", ":split<CR>", { noremap = true, silent = true })

-- Navigate to the window above
vim.api.nvim_set_keymap("n", "<Space>wj", "<C-w>j", { noremap = true, silent = true })

-- Navigate to the window below
vim.api.nvim_set_keymap("n", "<Space>wk", "<C-w>k", { noremap = true, silent = true })

-- Navigate to the window on the left
vim.api.nvim_set_keymap("n", "<Space>wh", "<C-w>h", { noremap = true, silent = true })

-- Navigate to the window on the right
vim.api.nvim_set_keymap("n", "<Space>wl", "<C-w>l", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Space>ot", ":term<CR>", { noremap = true, silent = true })
