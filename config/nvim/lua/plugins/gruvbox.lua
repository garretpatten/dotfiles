-- Hex palette: config/ghostty/themes/gruvbox-dark-hard-contrast (Gruvbox dark hard)
return {
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        transparent_mode = false,
        terminal_colors = true,
      })
      vim.o.background = "dark"
      vim.cmd.colorscheme("gruvbox")
    end,
  },
}
