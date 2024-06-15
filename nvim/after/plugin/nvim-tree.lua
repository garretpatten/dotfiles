require ("nvim-tree").setup()

vim.keymap.set('n', '<leader>to', vim.cmd.NvimTreeOpen)
vim.keymap.set('n', '<leader>tt', vim.cmd.NvimTreeToggle)
