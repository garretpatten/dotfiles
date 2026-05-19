local specs = {}
for _, name in ipairs({
  "gruvbox",
  "telescope",
  "treesitter",
  "cmp",
  "extra",
  "ui",
}) do
  vim.list_extend(specs, require("plugins." .. name))
end
return specs
