-- Language server table for vim.lsp.config()/vim.lsp.enable() (Neovim 0.12 API).
-- nvim-lspconfig only supplies the defaults (cmd, filetypes, root markers);
-- entries here are merged on top of them.
--   name     : mason package name, used by mason-tool-installer
--   config   : extra fields merged into the server's config
--   disabled : true skips both install and enable
return {
  html = {
    name = "html-lsp",
  },
  pyright = {
    name = "pyright",
    config = {
      root_markers = { ".git" },
      settings = {
        python = {
          analysis = {
            diagnosticMode = "openFilesOnly",
            typeCheckingMode = "off",
          },
        },
      },
    },
  },
  rust_analyzer = {
    name = "rust-analyzer",
    config = {
      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            enable = true,
            experimental = {
              enable = true,
            },
          },
        },
      },
    },
  },
  clangd = {
    name = "clangd",
    config = {
      cmd = { "clangd", "--offset-encoding=utf-16" },
    },
  },
  -- gopls = {
  --   name = "gopls",
  -- },
  ts_ls = {
    name = "typescript-language-server",
  },

  cssls = {
    name = "css-lsp",
  },
  jsonls = {
    name = "json-lsp",
  },
  volar = {
    name = "vue-language-server",
  },
  tailwindcss = {
    name = "tailwindcss-language-server",
  },
  astro = {
    name = "astro-language-server",
  },
  lua_ls = {
    name = "lua-language-server",
    config = {
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    },
  },
  solidity = {
    name = "nomicfoundation-solidity-language-server",
    config = {
      cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
      filetypes = { "solidity" },
      single_file_support = true,
    },
  },
  dockerls = {
    name = "dockerfile-language-server",
  },
}
