local specs = {}
for _, name in ipairs({
  "everforest",
  "telescope",
  "treesitter",
  "cmp",
  "extra",
  "ui",
}) do
  vim.list_extend(specs, require("plugins." .. name))
end
return specs
