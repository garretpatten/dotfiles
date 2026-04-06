return {
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
  },
  { "mg979/vim-visual-multi" },
  { "tpope/vim-commentary" },
}
