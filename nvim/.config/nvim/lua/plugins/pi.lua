-- lazy.nvim
return {
  "pablopunk/pi.nvim",
  dependencies = {}, -- optional
  config = function()
    require("pi").setup({
      -- context tuning
      max_context_lines = 300,
      max_context_bytes = 24000,
      selection_context_lines = 40,

      -- logging
      log_path = "/tmp/pi-nvim.log",

      -- features
      skills = true,
      extensions = true,
      tools = true,
    })

    -- Keymaps
    local map = vim.keymap.set

    -- Ask Pi with current file as context
    map("n", "<leader>ai", "<cmd>PiAsk<CR>", {
      desc = "Ask Pi",
    })

    -- optional: uses your pi CLI defaults if omitted
    -- Ask Pi using visual selection
    map("v", "<leader>ai", "<cmd>PiAskSelection<CR>", {
      desc = "Ask Pi Selection",
    })

    -- Cancel running request
    map("n", "<leader>ac", "<cmd>PiCancel<CR>", {
      desc = "Cancel Pi",
    })

    -- Open Pi logs
    map("n", "<leader>al", "<cmd>PiLog<CR>", {
      desc = "Pi Log",
    })
  end,
}
