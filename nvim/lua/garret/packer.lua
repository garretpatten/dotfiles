-- =============================================================================
-- Packer Plugin Manager Configuration
-- =============================================================================
-- This module manages all Neovim plugins using Packer
-- Documentation: https://github.com/wbthomason/packer.nvim

-- Bootstrap Packer if not installed
vim.cmd [[packadd packer.nvim]]

-- =============================================================================
-- Plugin Configuration
-- =============================================================================
return require('packer').startup(function(use)
    -- =============================================================================
    -- Plugin Manager
    -- =============================================================================
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- =============================================================================
    -- Fuzzy Finder
    -- =============================================================================
    -- Telescope: Fuzzy finder for Neovim
    use {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        requires = {
            { "nvim-lua/plenary.nvim" }
        }
    }

    -- Telescope FZF native: Fast fuzzy finder
    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make"
    }

    -- =============================================================================
    -- Syntax Highlighting
    -- =============================================================================
    -- Tree Sitter: Advanced syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    -- Tree Sitter Playground: Debug tree sitter
    use('nvim-treesitter/playground')

    -- =============================================================================
    -- Language Server Protocol
    -- =============================================================================
    -- LSP Configuration
    use "neovim/nvim-lspconfig"

    -- =============================================================================
    -- Completion Engine
    -- =============================================================================
    -- Nvim CMP: Completion engine
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'

    -- =============================================================================
    -- Editing Enhancements
    -- =============================================================================
    -- Visual Multi: Multiple cursors
    use "mg979/vim-visual-multi"

    -- Commentary: Comment/uncomment lines
    use "tpope/vim-commentary"

    -- Undo Tree: Visual undo history
    use('mbbill/undotree')

    -- =============================================================================
    -- UI Enhancements
    -- =============================================================================
    -- Alpha: Startup screen
    use {
        'goolord/alpha-nvim',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    }

    -- Lualine: Status line
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true }
    }

    -- =============================================================================
    -- Color Scheme
    -- =============================================================================
    -- Everforest: Beautiful color scheme
    use({
        "neanias/everforest-nvim",
        as = 'everforest',
        config = function()
            vim.cmd('colorscheme everforest')
        end
    })
end)
