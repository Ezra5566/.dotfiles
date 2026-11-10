local function lsp_related_ui_adjust()
  -- Floating window borders (hover, signature help, diagnostics, ...) come from
  -- the global 'winborder' option now — vim.lsp.with() was removed in Nvim 0.12.

  vim.diagnostic.config({
    virtual_text = {
      prefix = "●",
    },
    float = {
      border = "rounded",
      source = true,
      prefix = " - ",
    },
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.INFO] = "",
      },
    },
  })
end

local function lspconfig_setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspKeymapsAndHints", { clear = true }),
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      local opts = { buffer = bufnr }

      vim.keymap.set("n", "<leader>dn", function()
        vim.diagnostic.jump({ count = 1, float = true })
      end, opts)
      vim.keymap.set("n", "<leader>dp", function()
        vim.diagnostic.jump({ count = -1, float = true })
      end, opts)
      vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set({ "i", "n" }, "<C-s>", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

      -- auto show diagnostic when cursor hold
      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
          local float_opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          }

          if not vim.b.diagnostics_pos then
            vim.b.diagnostics_pos = { nil, nil }
          end

          local cursor_pos = vim.api.nvim_win_get_cursor(0)
          if
            (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
            and #vim.diagnostic.get() > 0
          then
            vim.diagnostic.open_float(nil, float_opts)
          end

          vim.b.diagnostics_pos = cursor_pos
        end,
      })

      -- Highlight references of the word under your cursor while it rests there.
      if client and client:supports_method("textDocument/documentHighlight") then
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = bufnr,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = bufnr,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd("LspDetach", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.clear_references()
          end,
        })
      end
    end,
  })

  -- blink.cmp advertises the snippet/completion capabilities of the client
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local blink_ok, blink = pcall(require, "blink.cmp")
  if blink_ok then
    capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())
  end

  ---Register a server through the native vim.lsp.config()/vim.lsp.enable() API
  ---@param server string lspconfig name (e.g. "lua_ls")
  ---@param config table|nil extra config merged on top of nvim-lspconfig defaults
  local setup_server = function(server, config)
    if type(config) ~= "table" then
      config = {}
    end

    config = vim.tbl_deep_extend("force", {
      capabilities = capabilities,
    }, config)

    vim.lsp.config(server, config)
    vim.lsp.enable(server)
  end

  local servers = require("plugins.lsp.language_servers")
  for server, setting in pairs(servers) do
    if not setting.disabled then
      setup_server(server, setting.config or {})
    end
  end
end

return {
  -- configuration for nvim lsp
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- managing tool
      { "mason-org/mason.nvim" },

      -- nvim-cmp/blink source for neovim's built-in LSP (capabilities)
      { "saghen/blink.cmp" },
    },
    config = function()
      lsp_related_ui_adjust()
      lspconfig_setup()
    end,
  },

  -- faster LuaLS setup for editing your Neovim config (replaces neodev.nvim)
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "{3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
