return {
  "sudo-tee/opencode.nvim",
  config = function()
    require("opencode").setup({})
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Optional, for file mentions and commands completion, pick only one
    "saghen/blink.cmp",
    -- 'hrsh7th/nvim-cmp',

    -- Optional, for file mentions picker, pick only one
    "folke/snacks.nvim",
    -- 'nvim-telescope/telescope.nvim',
    -- 'ibhagwan/fzf-lua',
    -- 'nvim_mini/mini.nvim',
  },
}
