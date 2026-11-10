-- Linting through nvim-lint only (none-ls is gone; its linters moved here).
return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("lint").linters_by_ft = {
        python = { "pylint" },
        dockerfile = { "hadolint" },
        go = { "staticcheck" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
