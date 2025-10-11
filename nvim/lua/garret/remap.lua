-- =============================================================================
-- Neovim Key Mappings Configuration
-- =============================================================================
-- This module contains all custom key mappings and remaps for Neovim
-- Organized by functionality for better maintainability

-- =============================================================================
-- Leader Key Configuration
-- =============================================================================
-- Set the leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =============================================================================
-- File Explorer
-- =============================================================================
-- Open file explorer (netrw)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

-- =============================================================================
-- Navigation Improvements
-- =============================================================================
-- Disable arrow keys to encourage hjkl usage
vim.keymap.set("", "<up>", "<nop>", { noremap = true, desc = "Disable up arrow" })
vim.keymap.set("", "<down>", "<nop>", { noremap = true, desc = "Disable down arrow" })
vim.keymap.set("", "<left>", "<nop>", { noremap = true, desc = "Disable left arrow" })
vim.keymap.set("", "<right>", "<nop>", { noremap = true, desc = "Disable right arrow" })

-- Disable arrow keys in insert mode
vim.keymap.set("i", "<up>", "<nop>", { noremap = true, desc = "Disable up arrow in insert" })
vim.keymap.set("i", "<down>", "<nop>", { noremap = true, desc = "Disable down arrow in insert" })
vim.keymap.set("i", "<left>", "<nop>", { noremap = true, desc = "Disable left arrow in insert" })
vim.keymap.set("i", "<right>", "<nop>", { noremap = true, desc = "Disable right arrow in insert" })

-- =============================================================================
-- Buffer Management
-- =============================================================================
-- Quick buffer switching
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { noremap = true, desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { noremap = true, desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { noremap = true, desc = "Delete buffer" })

-- =============================================================================
-- Window Management
-- =============================================================================
-- Split windows
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { noremap = true, desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { noremap = true, desc = "Split window horizontally" })

-- Window navigation
vim.keymap.set("n", "<leader>wh", "<C-w>h", { noremap = true, desc = "Move to left window" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { noremap = true, desc = "Move to down window" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { noremap = true, desc = "Move to up window" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { noremap = true, desc = "Move to right window" })

-- Window resizing
vim.keymap.set("n", "<leader>w=", "<C-w>=", { noremap = true, desc = "Make windows equal size" })
vim.keymap.set("n", "<leader>w+", "<C-w>+", { noremap = true, desc = "Increase window height" })
vim.keymap.set("n", "<leader>w-", "<C-w>-", { noremap = true, desc = "Decrease window height" })
vim.keymap.set("n", "<leader>w>", "<C-w>>", { noremap = true, desc = "Increase window width" })
vim.keymap.set("n", "<leader>w<", "<C-w><", { noremap = true, desc = "Decrease window width" })

-- =============================================================================
-- Search and Replace
-- =============================================================================
-- Clear search highlighting
vim.keymap.set("n", "<leader>nh", ":nohlsearch<CR>", { noremap = true, desc = "Clear search highlighting" })

-- Search and replace
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { noremap = true, desc = "Search and replace word under cursor" })

-- =============================================================================
-- Quick Actions
-- =============================================================================
-- Save file
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, desc = "Save file" })

-- Quit
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, desc = "Quit" })

-- Force quit
vim.keymap.set("n", "<leader>Q", ":q!<CR>", { noremap = true, desc = "Force quit" })

-- =============================================================================
-- Indentation
-- =============================================================================
-- Indent/unindent in visual mode
vim.keymap.set("v", "<", "<gv", { noremap = true, desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { noremap = true, desc = "Indent right" })

-- =============================================================================
-- Movement Improvements
-- =============================================================================
-- Move to beginning/end of line
vim.keymap.set("n", "H", "^", { noremap = true, desc = "Move to beginning of line" })
vim.keymap.set("n", "L", "$", { noremap = true, desc = "Move to end of line" })

-- Move by word
vim.keymap.set("n", "B", "b", { noremap = true, desc = "Move to previous word" })
vim.keymap.set("n", "W", "w", { noremap = true, desc = "Move to next word" })

-- =============================================================================
-- Copy and Paste
-- =============================================================================
-- Copy to system clipboard
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { noremap = true, desc = "Copy line to system clipboard" })

-- Paste from system clipboard
vim.keymap.set("n", "<leader>p", '"+p', { noremap = true, desc = "Paste from system clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { noremap = true, desc = "Paste before cursor from system clipboard" })

-- =============================================================================
-- Undo and Redo
-- =============================================================================
-- Undo tree toggle
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })

-- =============================================================================
-- Quick Fix
-- =============================================================================
-- Quick fix navigation
vim.keymap.set("n", "<leader>cn", ":cnext<CR>", { noremap = true, desc = "Next quick fix" })
vim.keymap.set("n", "<leader>cp", ":cprev<CR>", { noremap = true, desc = "Previous quick fix" })
vim.keymap.set("n", "<leader>cc", ":cclose<CR>", { noremap = true, desc = "Close quick fix" })

-- =============================================================================
-- Terminal
-- =============================================================================
-- Open terminal
vim.keymap.set("n", "<leader>t", ":terminal<CR>", { noremap = true, desc = "Open terminal" })

-- =============================================================================
-- Plugin Specific Mappings
-- =============================================================================
-- These will be overridden by plugin configurations in after/plugin/
