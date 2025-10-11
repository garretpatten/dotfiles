-- =============================================================================
-- Neovim Settings Configuration
-- =============================================================================
-- This module contains all the general settings and options for Neovim
-- Organized by category for better maintainability

-- =============================================================================
-- Look and Feel
-- =============================================================================
-- Enable syntax highlighting
vim.cmd("syntax on")

-- Enable file type detection and plugins
vim.cmd("filetype on")
vim.cmd("filetype plugin on")
vim.cmd("filetype indent on")

-- Color column at 80 characters
vim.opt.colorcolumn = "80"

-- Highlight current line
vim.opt.cursorline = true

-- Enable folding
vim.opt.foldenable = true

-- GUI font (for GUI versions of Neovim)
vim.opt.guifont = "Fira Code:h12"

-- Disable line wrapping
vim.opt.wrap = false

-- Set regex engine (0 = auto, 1 = old, 2 = new)
vim.opt.re = 0

-- Show command in status line
vim.opt.showcmd = true

-- Show matching brackets
vim.opt.showmatch = true

-- Show current mode
vim.opt.showmode = true

-- Enable true color support
vim.opt.termguicolors = true

-- Wild menu completion mode
vim.opt.wildmode = "longest,list"

-- =============================================================================
-- File Management
-- =============================================================================
-- Disable backup files
vim.opt.backup = false

-- Backup directory
vim.opt.backupdir = vim.fn.expand("~/.cache/vim")

-- Enable binary mode
vim.opt.binary = true

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Disable vi compatibility
vim.opt.compatible = false

-- File encoding
vim.opt.encoding = "utf-8"

-- Disable mouse support
vim.opt.mouse = ""

-- Disable swap files
vim.opt.swapfile = false

-- Undo directory
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Enable persistent undo
vim.opt.undofile = true

-- Update time for CursorHold events
vim.opt.updatetime = 50

-- =============================================================================
-- Navigation and Display
-- =============================================================================
-- Show line numbers
vim.opt.nu = true

-- Show relative line numbers
vim.opt.relativenumber = true

-- Minimum lines to keep above/below cursor
vim.opt.scrolloff = 8

-- =============================================================================
-- Search Configuration
-- =============================================================================
-- Disable search highlighting
vim.opt.hlsearch = false

-- Enable incremental search
vim.opt.incsearch = true

-- Ignore case in searches
vim.opt.ignorecase = true

-- Show matching brackets
vim.opt.showmatch = true

-- Smart case sensitivity
vim.opt.smartcase = true

-- =============================================================================
-- Indentation and Whitespace
-- =============================================================================
-- Enable auto indentation
vim.opt.autoindent = true

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Characters to show for whitespace
vim.opt.listchars = {
    space = '·',
    tab = '=>',
    trail = '~',
    nbsp = '␣',
    eol = '↴'
}

-- Show whitespace characters
vim.opt.list = true

-- Number of spaces for indentation
vim.opt.shiftwidth = 4

-- Enable smart indentation
vim.opt.smartindent = true

-- Number of spaces for soft tabs
vim.opt.softtabstop = 4

-- Number of spaces for hard tabs
vim.opt.tabstop = 4

-- =============================================================================
-- File Type Specific Settings
-- =============================================================================
-- Enable spell checking for markdown files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
    end
})

-- Disable Perl provider (if not needed)
vim.g.loaded_perl_provider = 0

-- =============================================================================
-- Performance Optimizations
-- =============================================================================
-- Reduce update time for better performance
vim.opt.updatetime = 50

-- =============================================================================
-- Additional Settings
-- =============================================================================
-- Enable hidden buffers (allow switching without saving)
vim.opt.hidden = true

-- Enable mouse support in all modes
vim.opt.mouse = "a"

-- Enable line wrapping for text files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "text", "markdown", "gitcommit" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
    end
})

-- Set default file format
vim.opt.fileformat = "unix"

-- Enable modeline support
vim.opt.modeline = true

-- Set modeline options
vim.opt.modelines = 5
