return {
  -- Default colorscheme (gruvbox)
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false, -- Load on startup
    priority = 1000, -- Make sure it's loaded first
    keys = {
      { "<leader>cl", "<cmd>Telescope colorscheme<cr>", desc = "Select Colorscheme with Preview" },
    },
    config = function()
      require("gruvbox").setup({
        transparent_mode = true,
        overrides = {
          String = { italic = false },
        },
      })
      vim.cmd("colorscheme gruvbox") -- Uncomment to set as default
    end,
  },

  -- -------------------------Extra colorscheme: catppuccin -----------------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    keys = {
      { "<leader>cl", "<cmd>Telescope colorscheme<cr>", desc = "Select Colorscheme with Preview" },
    },
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
      })
      -- vim.cmd("colorscheme catppuccin") -- Uncomment to set as default
    end,
  },

  -- -------------------------Extra colorscheme: gruvbox-material -----------------------------
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    keys = {
      { "<leader>cl", "<cmd>Telescope colorscheme<cr>", desc = "Select Colorscheme with Preview" },
    },
    config = function()
      vim.g.gruvbox_material_transparent_background = 1
      -- vim.cmd("colorscheme gruvbox-material") -- Uncomment to set as default
    end,
  },

  -- -------------------------Extra colorscheme: sonokai -----------------------------
  {
    "sainnhe/sonokai",
    lazy = true,
    keys = {
      { "<leader>cl", "<cmd>Telescope colorscheme<cr>", desc = "Select Colorscheme with Preview" },
    },
    config = function()
      vim.g.sonokai_transparent_background = 1
      -- vim.cmd("colorscheme sonokai") -- Uncomment to set as default
    end,
  },

  -- -------------------------Extra colorscheme: edge -----------------------------
  {
    "sainnhe/edge",
    lazy = true,
    keys = {
      { "<leader>cl", "<cmd>Telescope colorscheme<cr>", desc = "Select Colorscheme with Preview" },
    },
    config = function()
      vim.g.edge_transparent_background = 1
      -- vim.cmd("colorscheme edge") -- Uncomment to set as default
    end,
  },

  -- -------------------------Extra colorscheme: cyberdream -----------------------------
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    keys = {
      { "<leader>cl", "<cmd>Telescope colorscheme<cr>", desc = "Select Colorscheme with Preview" },
    },
    config = function()
      vim.g.cyberdream_transparent_background = 1
      require("cyberdream").setup({
        transparent = true,
        italic_comments = true,
        hide_fillchars = true,
        terminal_colors = false,
        cache = true,
        borderless_telescope = { border = false, style = "flat" },
      })
      -- vim.cmd("colorscheme cyberdream") -- Uncomment to set as default
    end,
  },
  ------------------Extra colorscheme: flow.nvim -----------------------------
  {
    "0xstepit/flow.nvim",
    lazy = true,
    keys = {
      { "<leader>cl", "<cmd>Telescope colorscheme<cr>", desc = "Select Colorscheme with Preview" },
    },
    config = function()
      require("flow").setup({
        dark_theme = true, -- Set the theme with dark background.
        high_contrast = true, -- Make the dark background darker or the light background lighter.
        transparent = true, -- Set transparent background (enabled transparency).
        fluo_color = "pink", -- Color used as fluo. Available values are pink, yellow, orange, or green.
        mode = "normal", -- Mode of the colors. Available values are: dark, bright, desaturate, or base.
        aggressive_spell = false,
      }) -- Use colors for spell check.
      -- vim.cmd("colorscheme flow") -- Uncomment to set as default
    end,
  },
}
