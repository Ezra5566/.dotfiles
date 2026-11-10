return {
  -- Modern formatter: replaces none-ls formatting sources (prettier, stylua)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo", "FormatToggle" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          html = { "prettier" },
          css = { "prettier" },
          scss = { "prettier" },
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          json = { "prettier" },
          jsonc = { "prettier" },
          markdown = { "prettier" },
        },
        formatters = {
          prettier = {
            prepend_args = { "--print-width", "120" },
          },
        },
        format_on_save = function(bufnr)
          local autoformat = require("plugins.formatting.autoformat")
          if not autoformat.autoformat then
            return nil
          end
          if vim.tbl_contains(autoformat.disable_autoformat, vim.bo[bufnr].filetype) then
            return nil
          end
          return { timeout_ms = 1000, lsp_format = "fallback" }
        end,
      })

      vim.api.nvim_create_user_command("FormatToggle", function()
        require("plugins.formatting.autoformat").toggle()
      end, { desc = "Toggle Format on Save" })
    end,
  },
}
