return {
  -- Treesitter (syntax highlighting + parsing)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
        },

        indent = {
          enable = true,
          disable = { "python" },
        },

        ensure_installed = {
          "vim",
          "vimdoc",
          "markdown",
          "markdown_inline",
          "bash",
          "regex",
          "c",
          "cpp",
          "go",
          "gomod",
          "java",
          "javascript",
          "typescript",
          "tsx",
          "json",
          "toml",
          "html",
          "css",
          "scss",
          "lua",
          "rust",
          "kdl",
        },

        auto_install = true,

        autotag = {
          enable = true,
        },

        -- textobjects (kept commented as in original)
        -- textobjects = {
        --   select = {
        --     enable = true,
        --     lookahead = true,
        --     keymaps = {
        --       ["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
        --       ["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
        --       ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
        --       ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        --     },
        --   },
        --   swap = {
        --     enable = true,
        --     swap_next = {
        --       ["<leader>xp"] = { query = "@parameter.inner", desc = "Swap parameter with the next one" },
        --     },
        --     swap_previous = {
        --       ["<leader>xP"] = { query = "@parameter.inner", desc = "Swap parameter with the previous one" },
        --     },
        --   },
        -- },
      })
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    enabled = true,
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Surround (updated for v4+)
  {
    "kylechui/nvim-surround",
    event = "BufReadPost",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Treesitter context
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    config = function()
      require("treesitter-context").setup({
        enable = false,
        max_lines = 0,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor",
        separator = nil,
        zindex = 20,
        on_attach = nil,
      })

      vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true })
      vim.keymap.set("n", "<leader>tc", ":TSContextToggle<CR>", { silent = true })
    end,
  },

  -- Helm syntax
  {
    "towolf/vim-helm",
  },
}
