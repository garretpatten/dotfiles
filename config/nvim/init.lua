vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Ensure Homebrew Ruby gems (e.g. solargraph) are visible to Mason regardless
-- of how Neovim was launched (GUI, tmux, etc. may not source ~/.zshrc).
vim.env.PATH = "/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/4.0.0/bin:" .. vim.env.PATH

require("config")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "lazy.nvim clone failed:\n", "ErrorMsg" },
      { out, "WarningMsg" },
    }, true, {})
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(require("config.lazy"))
