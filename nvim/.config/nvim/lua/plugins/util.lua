return {
  -- Distraction-free coding comes from snacks.zen now (mapped to <leader>z
  -- in plugins/snack.lua) — the standalone zen-mode.nvim plugin is gone.

  -- to do comments
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    lazy = false, -- keep the highlights at startup, `keys` are just extras
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next Todo Comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous Todo Comment",
      },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      {
        "<leader>xT",
        "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",
        desc = "Todo/Fix/Fixme (Trouble)",
      },
    },
    config = function()
      require("todo-comments").setup({})
    end,
  },

  -- folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      vim.o.foldcolumn = "0" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`.
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

      -- Adding number suffix of folded lines instead of the default ellipsis
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("  %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end

      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
        fold_virt_text_handler = handler,
        open_fold_hl_timeout = 200,
      })
    end,
  },

  -- auto detect indent
  {
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup()
    end,
  },

  -- git wrapper
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    config = function() end,
  },

  -- displays a popup with possible keybindings of the command
  {
    "folke/which-key.nvim",
    dependencies = {
      "echasnovski/mini.icons",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      vim.o.timeout = true
      vim.timeoutlen = 300
      require("which-key").setup({
        plugins = {
          presets = {
            g = false,
          },
        },
        win = {
          border = "single",
        },
        -- LazyVim-style group labels (only prefixes that are not already a
        -- direct mapping here, so nothing gets shadowed)
        spec = {
          { "<leader>b", group = "buffer" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>q", group = "quit/session" },
          { "<leader>x", group = "diagnostics/quickfix" },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "z", group = "fold" },
        },
      })
    end,
  },

  -- lua library for neovim
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  -- File explorer: replaced oil.nvim by the Snacks tree explorer (the style
  -- from the LazyVim backup). See plugins/snack.lua for the keymaps.

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    keys = {
      { "<leader>mp", "<CMD>MarkdownPreviewToggle<CR>", mode = "n", desc = "Markdown preview" },
    },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      if _G.IS_WSL then
        -- Open the preview page in new window
        vim.cmd([[
          function! MdpOpenPreview(url) abort
            let l:mdp_browser = '/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe'
            let l:mdp_browser_opts = '--new-window'
            if !filereadable(substitute(l:mdp_browser, '\\ ', ' ', 'g'))
              let l:mdp_browser = '/mnt/c/Program\ Files\ (x86)/Microsoft/Edge/Application/msedge.exe'
              let l:mdp_browser_opts = '--new-window'
            endif
            execute join(['silent! !', l:mdp_browser, l:mdp_browser_opts, a:url])
          endfunction
          let g:mkdp_browserfunc = 'MdpOpenPreview'
      ]])
      end
      -- vim.g.mkdp_echo_preview_url = 1 -- set to 1, echo preview page URL in command line when opening preview page
    end,
  },
}
