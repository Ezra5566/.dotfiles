-- Setup globals that I expect to be always available.
require("ezzdev.globals")

-- Mapping leader key to: " "
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("ezzdev.options")
require("ezzdev.autocmds")
require("ezzdev.keymaps")

-- Install lazy.nvim (package manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

-- Lazy.nvim setup
require("lazy").setup({
  spec = {
    { import = "plugins" }, -- Import your plugin configurations
  },
  install = {
    colorscheme = { "catppuccin", "gruvbox" },
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
