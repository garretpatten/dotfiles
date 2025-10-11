-- =============================================================================
-- Telescope Configuration
-- =============================================================================
-- Fuzzy finder configuration for Neovim
-- Documentation: https://github.com/nvim-telescope/telescope.nvim

local builtin = require('telescope.builtin')

-- =============================================================================
-- Key Mappings
-- =============================================================================
-- Find files in current directory
vim.keymap.set('n', '<leader>pf', builtin.find_files, {
    desc = "Find files"
})

-- Find files in git repository
vim.keymap.set('n', '<leader>gf', builtin.git_files, {
    desc = "Find git files"
})

-- Search for string in files
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ")});
end, { desc = "Search for string" })

-- Find buffers
vim.keymap.set('n', '<leader>pb', builtin.buffers, {
    desc = "Find buffers"
})

-- Find help tags
vim.keymap.set('n', '<leader>ph', builtin.help_tags, {
    desc = "Find help tags"
})

-- Live grep
vim.keymap.set('n', '<leader>pg', builtin.live_grep, {
    desc = "Live grep"
})

-- =============================================================================
-- Load Extensions
-- =============================================================================
-- Load FZF extension for better performance
require("telescope").load_extension("fzf")
