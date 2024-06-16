-- Look and Feel -----------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function() vim.opt_local.spell = true end
})
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.foldenable = true
vim.opt.guifont = "Fira Code:h12"
vim.opt.wrap = false
vim.opt.re = 0
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.showmode = true
vim.opt.termguicolors = true
vim.opt.wildmode = "longest,list"
vim.cmd("syntax on")

-- Files -----------------------------------------------------
vim.cmd("filetype on")
vim.cmd("filetype plugin on")
vim.cmd("filetype indent on")

-- Misc -----------------------------------------------------
vim.g.loaded_perl_provider = 0
vim.opt.backup = false
vim.opt.backupdir = vim.fn.expand("~/.cache/vim")
vim.opt.binary = true
vim.opt.clipboard = "unnamedplus"
vim.opt.compatible = false
vim.opt.encoding = "utf-8"
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 50

-- Navigation -----------------------------------------------------
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8

-- Searching -----------------------------------------------------
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.showmatch = true
vim.opt.smartcase = true

-- Whitespace -----------------------------------------------------
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.listchars = { space = '·', tab = '=>' }
vim.opt.list = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
