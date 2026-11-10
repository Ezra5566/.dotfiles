return {
  -- nerd font supported icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  --------------------------------- buffer/tab line (ported from the backup)----
  -- NOTE: <S-h>/<S-l> are intentionally NOT bound to buffers here, they are
  -- your "start/end of line" motions in ezzdev/keymaps.lua.
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
      { "<leader>bj", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
    },
    opts = {
      options = {
        -- stylua: ignore
        close_command = function(n) Snacks.bufdelete(n) end,
        -- stylua: ignore
        right_mouse_command = function(n) Snacks.bufdelete(n) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = { Error = " ", Warn = " " }
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          { filetype = "snacks_layout_box" },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })

      -- Keep the terminal background visible through the tab line: bufferline
      -- paints solid colours, so strip the bg from its groups and redo it on
      -- every colorscheme change (transparency first).
      local util = require("util")
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("bufferline-transparency", { clear = true }),
        callback = function()
          util.transparentize({ "^BufferLine" })
        end,
      })
      util.transparentize({ "^BufferLine" })
    end,
  },
  --------------------------------- status line----------------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local colors = {
        bg = "#66000000", -- Transparent background
        fg = "#bbc2cf",
        yellow = "#ECBE7B",
        cyan = "#008080",
        darkblue = "#081633",
        green = "#98be65",
        orange = "#FF8800",
        violet = "#a9a1e1",
        magenta = "#c678dd",
        blue = "#82AAFF",
        red = "#ec5f67",
      }

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand("%:p:h")
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }

      local config = {
        options = {
          theme = {
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
          },
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = { "snacks_dashboard" },
            winbar = {},
          },
          refresh = {
            statusline = 500,
          },
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
      }

      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end

      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end

      ins_left({
        function()
          return "▊"
        end,
        color = { fg = colors.green },
        padding = { left = 0, right = 1 },
      })

      ins_left({
        function()
          local mode_icons = {
            n = "", -- Normal mode icon
            i = "", -- Insert mode icon
            v = "󰃤", -- Visual mode icon
            ["\22"] = "󰃤", -- Visual block mode icon
            V = "󰃤", -- Visual line mode icon
            c = "", -- Command mode icon
          }
          return mode_icons[vim.fn.mode()] or "" -- Default icon
        end,
        color = function()
          local mode_color = {
            n = colors.green, -- Normal mode color
            i = colors.blue, -- Insert mode color
            v = colors.red, -- Visual mode color
          }
          return { fg = mode_color[vim.fn.mode()] or colors.fg }
        end,
        padding = { right = 1 },
      })

      ins_left({ "filesize", cond = conditions.buffer_not_empty })
      ins_left({ "filename", cond = conditions.buffer_not_empty, color = { fg = colors.magenta, gui = "bold" } })
      ins_left({ "location" })
      ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

      ins_left({
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " " },
        diagnostics_color = {
          color_error = { fg = colors.red },
          color_warn = { fg = colors.yellow },
          color_info = { fg = colors.cyan },
        },
      })

      ins_left({
        function()
          return "%="
        end,
      })

      -- OpenCode component
      ins_left({
        function()
          local ok, opencode = pcall(require, "opencode")
          if not ok then
            return " OpenCode: Off"
          end

          local enabled = false
          if opencode.is_enabled then
            enabled = opencode.is_enabled()
          end

          if enabled then
            return " OpenCode: On"
          else
            return " OpenCode: Off"
          end
        end,
        color = { fg = colors.cyan, gui = "bold" },
      })

      -- LSP status component (clients attached to the current buffer)
      ins_left({
        function()
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          if #clients == 0 then
            return "No Active Lsp"
          end
          return clients[1].name
        end,
        icon = " LSP:",
        color = { fg = "#ffffff", gui = "bold" },
      })

      ins_right({
        "o:encoding",
        fmt = string.upper,
        cond = conditions.hide_in_width,
        color = { fg = colors.green, gui = "bold" },
      })

      ins_right({ "fileformat", fmt = string.upper, icons_enabled = false, color = { fg = colors.green, gui = "bold" } })
      ins_right({ "branch", icon = "", color = { fg = colors.violet, gui = "bold" } })
      ins_right({
        "diff",
        symbols = { added = " ", modified = "󰝤 ", removed = " " },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
        cond = conditions.hide_in_width,
      })

      -- live-server indicator (state comes from the :LiveServer command)
      ins_right({
        function()
          if vim.g.liveserver_bufnr ~= nil then
            return "󱄙"
          end
          return ""
        end,
        color = { fg = "#268bd2" },
      })

      ins_right({
        function()
          return "▊"
        end,
        color = { fg = colors.blue },
        padding = { left = 1 },
      })

      -- Initialize lualine with this setup
      require("lualine").setup(config)

      -- Hide the mode in the command line
      vim.opt.showmode = false
    end,
  },

  ------------------------- color highlighter--------------------------------------------------
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufEnter",
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          names = false,
          tailwind = "both",
          mode = "background",
        },
      })
    end,
  },

  -------------------------- git decorations-----------------------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
        },
        current_line_blame = false,
        current_line_blame_opts = {
          delay = 200,
        },
        -- LazyVim-style hunk mappings (ported from the backup)
        on_attach = function(buffer)
          local gs = package.loaded.gitsigns
          local function bmap(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
          end
          -- stylua: ignore start
          bmap("n", "]h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gs.nav_hunk("next")
            end
          end, "Next Hunk")
          bmap("n", "[h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gs.nav_hunk("prev")
            end
          end, "Prev Hunk")
          bmap("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
          bmap("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
          bmap({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
          bmap({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
          bmap("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
          bmap("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
          bmap("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
          bmap("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
          bmap("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
          bmap("n", "<leader>ghB", gs.blame, "Blame Buffer")
          bmap("n", "<leader>ghd", gs.diffthis, "Diff This")
          bmap("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
          bmap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
          -- stylua: ignore end
        end,
      })
    end,
  },

  --------------------------------- Standalone UI for nvim-lsp progress-------------------------------
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    config = function()
      require("fidget").setup({
        progress = {
          poll_rate = 200,
          ignore_done_already = true,
          display = {
            done_ttl = 0.5,
            -- Icon shown when LSP progress tasks are in progress
            progress_icon = { pattern = "meter", period = 1 },
            -- Highlight group for in-progress LSP tasks
            progress_style = "WarningMsg",
            group_style = "WarningMsg", -- Highlight group for group name (LSP server name)
            icon_style = "WarningMsg", -- Highlight group for group icons
            done_style = "Conditional", -- Highlight group for completed LSP tasks
          },
        },
        notification = {
          window = {
            winblend = 0,
          },
        },
      })
    end,
  },

  ---------------------------------- Neovim plugin to improve the default vim.ui interfaces---------------------------
  -- dressing.nvim was removed: snacks.input (enabled in plugins/snack.lua)
  -- covers vim.ui.input/select already.

  {
    "echasnovski/mini.animate",
    version = false,
    cmd = "CoworkingToggle",
    config = function()
      local isCoworking = false
      local animate = require("mini.animate")
      local Util = require("lazy.core.util")

      local coworking_setup = function()
        if isCoworking then
          animate.setup({
            cursor = { enable = false },
            scroll = {
              enable = true,
              timing = animate.gen_timing.cubic({ duration = 50, unit = "total" }),
            },
            resize = { enable = false },
            open = { enable = false },
            close = { enable = false },
          })

          vim.keymap.set("n", "<C-d>", "<C-d>")
          vim.keymap.set("n", "<C-u>", "<C-u>")

          vim.opt.relativenumber = false
          vim.opt.number = true
        else
          animate.setup({
            cursor = { enable = false },
            scroll = { enable = false },
            resize = { enable = false },
            open = { enable = false },
            close = { enable = false },
          })

          vim.keymap.set("n", "<C-d>", "<C-d>zz")
          vim.keymap.set("n", "<C-u>", "<C-u>zz")

          vim.opt.relativenumber = true
          vim.opt.number = true
        end
      end

      vim.api.nvim_create_user_command("CoworkingToggle", function()
        isCoworking = not isCoworking
        if isCoworking then
          Util.warn("Enabled coworking mode", { title = "Coworking" })
        else
          Util.info("Disabled coworking mode", { title = "Coworking" })
        end
        coworking_setup()
      end, { desc = "Toggle coworking mode (add scrolling animation)" })

      coworking_setup()
    end,
  },

  -- lazy.nvim------------------config-for-nvim-notifications----------------------
  -- (alpha-nvim, dressing, indent-blankline and statuscol.nvim were removed:
  --  snacks.nvim covers all of them, see plugins/snack.lua)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        progress = {
          enabled = false, -- fidget.nvim shows LSP progress
        },
      },
      -- current noice schema: position/size live under `views`, the old
      -- top-level `cmdline_popup` key was silently ignored
      views = {
        cmdline_popup = {
          position = {
            row = 15,
            col = "50%",
          },
          size = {
            width = "auto",
            height = "auto",
          },
        },
      },
    },
  },
}
