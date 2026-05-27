return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Linters
          "actionlint",
          "eslint_d",
          "hadolint",
          "markdownlint",
          "ruff",
          "shellcheck",
          "yamllint",

          -- Formatters (installed here so Mason manages them, used by conform)
          "prettierd",
          "shfmt",
          "stylua",
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        zsh = { "shellcheck" },
        yaml = { "yamllint" },
        dockerfile = { "hadolint" },
        markdown = { "markdownlint" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        python = { "ruff" },
      }

      -- actionlint only applies to GitHub Actions files, not all YAML
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
        pattern = { "*.yml", "*.yaml" },
        callback = function()
          local path = vim.fn.expand("%:p")
          if path:match("%.github/workflows") or path:match("%.github/actions") then
            lint.try_lint("actionlint")
          end
        end,
      })

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint()
      end, { desc = "Trigger linting" })
    end,
  },
}
