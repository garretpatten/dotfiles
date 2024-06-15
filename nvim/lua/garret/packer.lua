vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    
    -- Telescope
    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.6",
        requires = {
            { "nvim-lua/plenary.nvim" }
        }
    }

    -- Fuzzy Find
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    -- Tree Sitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use('nvim-treesitter/playground')
    use('mbbill/undotree')

    -- LSP
    use "neovim/nvim-lspconfig"

    -- Nvim Completion Engine
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- Nvim Visual Multi (Visual mode, ctrl + n)
    use "mg979/vim-visual-multi"

    -- Alpha Nvim
    use {
        'goolord/alpha-nvim',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    }

    -- Lua Line
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true }
    }

    -- Everforest Theme
    use({ 
        "neanias/everforest-nvim",
        as = 'everforest',
        config = function()
            vim.cmd('colorscheme everforest')
        end
    })

    -- Nvim Tree
    use "nvim-tree/nvim-tree.lua"
end)
