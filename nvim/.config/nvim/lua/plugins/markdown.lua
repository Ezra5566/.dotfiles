return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    -- Define options here
    keybindings = {
      preview = "K", -- Keybinding for preview
    },
    line_numbers = false, -- Disable line numbers in Markdown preview
    transparency = 0.8, -- Minimal transparency
    border = "rounded", -- Simulate curved edges with rounded borders
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons", -- For icons
  },
}
