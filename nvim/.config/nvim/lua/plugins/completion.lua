return {
  -- Modern, performant completion engine (replaces nvim-cmp + cmp-* sources +
  -- LuaSnip + lspkind). Snippets use Neovim's built-in snippet engine and
  -- cmdline completion is built in as well.
  {
    "saghen/blink.cmp",
    -- pin the stable release: the fuzzy matcher ships a prebuilt native lib
    -- per tag, and tracking `main` (v2 dev) leaves it without one
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    -- make sure the native fuzzy library ends up on disk: v1 downloads the
    -- prebuilt one itself on setup, v2 needs an explicit `download()` call
    -- (`:Lazy build blink.cmp` re-runs this)
    build = function()
      local blink = require("blink.cmp")
      if blink.download then
        blink.download({}):pwait()
      end
    end,
    dependencies = {
      "saghen/blink.lib", -- extracted from blink.cmp in v2, required at runtime
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      vim.opt.completeopt = "menu,menuone,noselect"
      vim.opt.pumheight = 10 -- Maximum number of items to show in the popup menu

      require("blink.cmp").setup({
        keymap = {
          preset = "default",
          -- same muscle memory as the old nvim-cmp setup
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-d>"] = { "scroll_documentation_down", "fallback" },
          ["<C-u>"] = { "scroll_documentation_up", "fallback" },
          ["<C-e>"] = { "hide", "fallback" },
          ["<C-Space>"] = { "show", "fallback" },
          -- Tab: accept the selected entry, jump snippet placeholders, else fall back
          ["<Tab>"] = { "accept", "snippet_forward", "fallback" },
          ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        },
        sources = {
          default = { "lazydev", "lsp", "path", "snippets", "buffer" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
          },
        },
        completion = {
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
          },
          ghost_text = { enabled = false }, -- copilot.lua shows its own suggestions
        },
        signature = { enabled = true },
        appearance = {
          nerd_font_variant = "mono",
        },
      })
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            -- accept = "<Down>",
            -- accept_line = "<Right>",
            next = "<M-j>",
            prev = "<M-k>",
          },
        },
        filetypes = {
          gitcommit = true,
          gitrebase = true,
          yaml = true,
          oil = false,
        },
      })
    end,
  },
}
