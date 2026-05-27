return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = { border = "rounded" },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("gD", vim.lsp.buf.declaration, "Go to declaration")
        map("gr", vim.lsp.buf.references, "Go to references")
        map("gi", vim.lsp.buf.implementation, "Go to implementation")
        map("K", vim.lsp.buf.hover, "Hover docs")
        map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("<leader>ds", vim.lsp.buf.document_symbol, "Document symbols")
        map("]d", vim.diagnostic.goto_next, "Next diagnostic")
        map("[d", vim.diagnostic.goto_prev, "Prev diagnostic")
        map("<leader>e", vim.diagnostic.open_float, "Open diagnostic float")
      end

      require("mason-lspconfig").setup({
        ensure_installed = {
          -- Scripting & config
          "lua_ls",
          "bashls",
          "jsonls",
          "yamlls",
          "taplo",       -- TOML
          "marksman",    -- Markdown

          -- Web
          "ts_ls",       -- JavaScript & TypeScript
          "html",
          "cssls",

          -- Systems & compiled
          "gopls",       -- Go
          "rust_analyzer",
          "clangd",      -- C / C++
          "jdtls",       -- Java

          -- Scripting
          "pyright",     -- Python
          "solargraph",  -- Ruby

          -- Infra
          "dockerls",
          "terraformls",
          "sqlls",
        },
        automatic_installation = true,
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
              on_attach = on_attach,
            })
          end,
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              capabilities = capabilities,
              on_attach = on_attach,
              settings = {
                Lua = {
                  runtime = { version = "LuaJIT" },
                  diagnostics = { globals = { "vim" } },
                  workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                  telemetry = { enable = false },
                },
              },
            })
          end,
          -- jdtls requires a data directory per-project; use the built-in defaults
          ["jdtls"] = function()
            require("lspconfig").jdtls.setup({
              capabilities = capabilities,
              on_attach = on_attach,
              cmd = {
                "jdtls",
                "-data",
                vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
              },
            })
          end,
        },
      })

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded" },
      })
    end,
  },
}
