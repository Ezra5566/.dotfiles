-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlighting", { clear = true }),
  pattern = "*",
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 100 })
  end,
})

-- Transparency guard -------------------------------------------------------
-- The colorscheme clears Normal/NormalNC, but floats and plugin surfaces
-- (bufferline's tab line, the snacks file explorer, trouble, telescope/which
-- key floats that resolve to NormalFloat, ...) paint their own backgrounds.
-- Strip them whenever a colorscheme is applied so the terminal background
-- always shows through. Selection/cursorline highlights are left alone.
local TRANSPARENT_PATTERNS = {
  "^NormalFloat$",
  "^Float(Border|Title|Footer)$",
  "^BufferLine",
  "^Trouble",
  "^Snacks(NormalNC|Header|Title|Footer|Border|Icon|Layout)",
  "^SnacksPicker",
}

local function enforce_transparency()
  require("util").transparentize(TRANSPARENT_PATTERNS)
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("TransparencyGuard", { clear = true }),
  callback = enforce_transparency,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = enforce_transparency,
})

enforce_transparency()

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("LastLoc", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- disable auto comment when insert new line after comment
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("FormatOptions", { clear = true }),
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({ "r", "o" })
  end,
})

-- instantly hide diagnostic when entering insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  group = vim.api.nvim_create_augroup("HideDiagnostic", { clear = true }),
  pattern = "*",
  callback = function()
    vim.diagnostic.enable(false)
  end,
})

-- instantly show diagnostic when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  group = vim.api.nvim_create_augroup("ShowDiagnostic", { clear = true }),
  pattern = "*",
  callback = function()
    vim.diagnostic.enable(true)
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})
