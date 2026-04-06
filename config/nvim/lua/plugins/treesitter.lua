return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "apex",
          "bash",
          "c",
          "go",
          "java",
          "javascript",
          "json",
          "lua",
          "markdown",
          "python",
          "query",
          "regex",
          "ruby",
          "rust",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },
  { "nvim-treesitter/playground" },
}
