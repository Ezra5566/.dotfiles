-- Setup globals that I expect to be always available.
require("ezzdev.globals")

-- Mapping leader key to: " "
vim.g.mapleader = " "

require("ezzdev.options")
require("ezzdev.autocmds")
require("ezzdev.keymaps")

-- Install lazy.nvim (package manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- Your existing setup...

-- Modify the lazy.nvim setup
require("lazy").setup({
  { import = "plugins" },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
}, {
  install = {
    colorscheme = { "gruvbox", "catppuccin" },
  },
  -- ... rest of your existing lazy.nvim configuration ...
})

-- Add this check after the lazy.nvim setup
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  print("Failed to load Telescope: " .. telescope)
else
  print("Telescope loaded successfully")
end
vim.g.lazy_show_reload_warning = false
-- Rest of your init.lua...
require("lazy").setup("plugins", {
  install = {
    colorscheme = { "gruvbox", "catppuccin" },
  },
  ui = {
    border = "rounded",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  change_detection = {
    notify = false,
  },
  dev = {
    path = "~/personal",
  },
})

-- close lazy panel with esc
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "lazy",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
