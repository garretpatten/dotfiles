-- Look and Feel -----------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function() vim.opt_local.spell = true end
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end
})

vim.cmd("colorscheme everforest")
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.foldenable = true
vim.opt.guifont = "Fira Code:h12"
vim.opt.wrap = false
vim.opt.re = 0
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.showmode = true
vim.opt.wildmode = "longest,list"
vim.cmd("syntax on")

-- Files -----------------------------------------------------
vim.cmd("filetype on")
vim.cmd("filetype plugin on")
vim.cmd("filetype indent on")

-- Misc -----------------------------------------------------
vim.g.loaded_perl_provider = 0
vim.opt.backupdir = vim.fn.expand("~/.cache/vim")
vim.opt.binary = true
vim.opt.clipboard = "unnamedplus"
vim.opt.encoding = "utf-8"
vim.opt.compatible = false

-- Navigation -----------------------------------------------------
vim.opt.relativenumber = true

-- Searching -----------------------------------------------------
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.showmatch = true
vim.opt.smartcase = true

-- Whitespace -----------------------------------------------------
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.listchars = { space = '·', tab = '=>' }
vim.opt.list = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
