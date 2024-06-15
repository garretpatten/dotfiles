" Look and Feel -----------------------------------------------------
autocmd FileType markdown setlocal spell
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
colorscheme everforest
set cc=80
set cursorline
set foldenable
set guifont=Fira\ Code:h12
set nowrap
set re=0
set showcmd
set showmatch
set showmode
set wildmode=longest,list
syntax on

" Files -----------------------------------------------------
filetype on
filetype plugin on
filetype indent on

" Misc -----------------------------------------------------
let g:loaded_perl_provider=0
set backupdir=~/.cache/vim
set binary                       " Handle files with mixed line endings better
set clipboard=unnamedplus
set encoding=utf-8
set nocompatible

" Navigation -----------------------------------------------------
set relativenumber

" Searching -----------------------------------------------------
set hlsearch
set ignorecase
set showmatch
set smartcase

" Whitespace -----------------------------------------------------
set autoindent
set expandtab                    " Turn tabs to spaces
set listchars=space:·,tab:=>     " Display special characters (whitespace)
set list
set shiftwidth=4                 " Set auto indent size to 4
set softtabstop=4                " Set insert mode tab size to 4
set tabstop=4                    " Set tab size to 4

" Plugins -----------------------------------------------------
lua << EOF
require('packer').startup(function()
    use 'wbthomason/packer.nvim'  -- Packer can manage itself

    -- Mason
    use {
        "williamboman/mason.nvim",
        run = ":MasonUpdate" -- :MasonUpdate updates registry contents
    }
    require("mason").setup()

    -- Alpha Nvim
    use {
        'goolord/alpha-nvim',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    }

    -- LSP
    use "neovim/nvim-lspconfig"

    -- Nvim Completion Engine
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- Git Gutter
    use "airblade/vim-gitgutter"

    -- Lua Line
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true }
    }
    require("lualine").setup()

    -- Nvim Visual Multi (Visual mode, ctrl + n)
    use "mg979/vim-visual-multi"

    -- Nvim Tree
    use "nvim-tree/nvim-tree.lua"
    require ("nvim-tree").setup()

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.6",
        requires = {
            { "nvim-lua/plenary.nvim" }
        }
    }

    -- Fuzzy Find
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    require("telescope").load_extension("fzf")

    -- Tree Sitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    require'nvim-treesitter.configs'.setup {
        -- A list of parser names
        ensure_installed = {
            "apex",
            "bash",
            "c",
            "go",
            "java",
            "javascript",
            "json",
            "json5",
            "lua",
            "markdown",
            "php",
            "python",
            "query",
            "regex",
            "ruby",
            "rust",
            "swift",
            "typescript",
            "vim",
            "vimdoc",
            "yaml"
        },
        highlight = {
            enable = true
        }
    }

    -- Themes
    use { "catppuccin/nvim", as = "catppuccin" }
    -- catppuccin-latte
    -- catppuccin-frappe
    -- catppuccin-macchiato
    -- catppuccin-mocha

    use 'navarasu/onedark.nvim'
    require('onedark').setup {
        -- Main options --
        style = 'darker', -- Default theme style.
        -- dark (default)
        -- darker
        -- cool
        -- deep
        -- warm
        -- warmer
        -- light
    }

    use "EdenEast/nightfox.nvim"
    -- Carbonfox
    -- Dayfox
    -- Dawnfox
    -- Duskfox
    -- Nordfox
    -- Terafox

    use ({ 'projekt0n/github-nvim-theme' })
    -- github_dark
    -- github_light
    -- github_dark_dimmed
    -- github_default
    -- github_dark_high_contrast
    -- github_light_high_contrast

    use({ "neanias/everforest-nvim" })
    require("everforest").load()
end)
    -- Set up nvim-cmp.
    local cmp = require'cmp'

    cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' }, -- For vsnip users.
            -- { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
        },
        {
            { name = 'buffer' },
        })
    })

    -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
    -- Set configuration for specific filetype.
    --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
    })
    require("cmp_git").setup() ]]-- 

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
        { name = 'path' }
    },
    {
        { name = 'cmdline' }
    }),
        matching = { disallow_symbol_nonprefix_matching = false }
    })

    -- Set up lspconfig.
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
EOF
