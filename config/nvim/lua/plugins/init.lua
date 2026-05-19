local specs = {}
local theme = require("config.theme")
for _, name in ipairs({
  theme,
  "telescope",
  "treesitter",
  "cmp",
  "extra",
  "ui",
}) do
  vim.list_extend(specs, require("plugins." .. name))
end
return specs
