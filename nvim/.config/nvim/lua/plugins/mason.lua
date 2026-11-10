return {
  -- managing tool
  {
    "mason-org/mason.nvim", -- repo moved from williamboman/ to mason-org/
    dependencies = {
      -- Install and upgrade third party tools automatically
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
          local language_servers = require("plugins.lsp.language_servers")

          local tool_names = {}
          for _, server in pairs(language_servers) do
            if not server.disabled then
              table.insert(tool_names, server.name)
            end
          end

          -- formatters (conform.nvim) + linters (nvim-lint)
          vim.list_extend(tool_names, { "prettier", "stylua", "hadolint", "pylint", "staticcheck" })

          require("mason-tool-installer").setup({
            ensure_installed = tool_names,
          })
        end,
      },
    },
    config = function()
      require("mason").setup({
        providers = {
          "mason.providers.registry-api", -- default
          "mason.providers.client",
        },
        ui = {
          height = 0.85,
          border = "rounded",
        },
      })

      -- mason-lspconfig is intentionally NOT used: servers are enabled
      -- explicitly through vim.lsp.enable() in plugins/lsp/init.lua, so there
      -- is a single source of truth for which servers run.
    end,
  },
}
