-- Leader Key
vim.g.mapleader = " "

-- Telescope
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Disable Mouse and Arrow Keys
vim.keymap.set("", "<up>", "<nop>", { noremap = true })
vim.keymap.set("", "<down>", "<nop>", { noremap = true })
vim.keymap.set("i", "<up>", "<nop>", { noremap = true })
vim.keymap.set("i", "<down>", "<nop>", { noremap = true })
