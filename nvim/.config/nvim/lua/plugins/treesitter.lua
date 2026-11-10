return {
  -- Treesitter (syntax highlighting + parsing)
  --
  -- nvim-treesitter was rewritten for Neovim 0.12 (the `main` branch) and the
  -- old `require("nvim-treesitter.configs").setup()` module is gone. Highlighting
  -- and indentation are now enabled per buffer through a FileType autocmd, and
  -- parsers are installed with `install()` instead of `ensure_installed`.
  -- NOTE: the plugin does not support lazy-loading on this branch.
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- Languages we want parsers for (replaces ensure_installed). Unknown
      -- names are skipped so a parser rename never breaks startup.
      local wanted = {
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
      }

      local ok_parsers, parsers = pcall(require, "nvim-treesitter.parsers")
      local supported = {}
      for _, name in ipairs(wanted) do
        if not ok_parsers or parsers[name] then
          table.insert(supported, name)
        end
      end
      require("nvim-treesitter").install(supported)

      -- Enable treesitter highlighting/indentation for filetypes that have a
      -- parser. Highlighting is a no-op when no parser/query exists (pcall).
      local indent_disabled = { python = true }
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TreesitterFeatures", { clear = true }),
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)

          if not indent_disabled[vim.bo[args.buf].filetype] then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },

  -- Autotag (own setup now, the old `autotag = { enable }` field inside
  -- nvim-treesitter.configs never did anything)
  {
    "windwp/nvim-ts-autotag",
    event = { "InsertEnter", "BufReadPost" },
    opts = {},
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
