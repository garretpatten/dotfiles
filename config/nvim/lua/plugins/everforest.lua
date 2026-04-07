return {
  {
    "neanias/everforest-nvim",
    name = "everforest",
    priority = 1000,
    config = function()
      require("everforest").load()
      vim.cmd.colorscheme("everforest")
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
  },
}
