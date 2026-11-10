local M = {}

--- Strip solid backgrounds from highlight groups so the terminal background
--- shows through (keeps the transparent look across plugins that paint their
--- own colours, e.g. bufferline, trouble).
---@param filters string[] Lua patterns matched against the highlight group name
M.transparentize = function(filters)
  for name, attrs in pairs(vim.api.nvim_get_hl(0, {})) do
    if type(name) == "string" and attrs.bg then
      for _, filter in ipairs(filters) do
        if name:find(filter) then
          attrs.bg = nil
          vim.api.nvim_set_hl(0, name, attrs)
          break
        end
      end
    end
  end
end

--- Nearest project root for a buffer (falls back to the cwd)
---@param bufnr? integer
---@return string
M.project_root = function(bufnr)
  return vim.fs.root(bufnr or 0, { ".git", ".hg", ".svn", ".bzr", "_darcs" }) or vim.fn.getcwd()
end

---A helper function to find configurations
---@param config_names string[] A list of config names you want to find (e.g. { ".stylua.toml", "stylua.toml" })
---@param default_dir string Default config directory (e.g. vim.fn.stdpath("config") .. "/lua/plugins/formatting/configs/")
---@return string config_dir The directory of first found configuration (project's config > default's config)
M.config_finder = function(config_names, default_dir)
  -- prevent that user not provide last seperator
  if string.sub(default_dir, string.len(default_dir)) ~= "/" then
    default_dir = default_dir .. "/"
  end

  -- search from project recursively (project's config)
  for _, name in ipairs(config_names) do
    local found_root = vim.fs.root(vim.uv.cwd(), name)
    if found_root then
      local config_dir = found_root .. "/" .. name
      if _G.IS_WINDOWS then
        config_dir = string.gsub(config_dir, "/", "\\")
      end
      return config_dir
    end
  end

  -- search from default_dir
  for _, name in ipairs(config_names) do
    if vim.uv.fs_stat(default_dir .. name) then
      local config_dir = default_dir .. name
      if _G.IS_WINDOWS then
        config_dir = string.gsub(config_dir, "/", "\\")
      end
      return config_dir
    end
  end

  return ""
end

--- Get greeting message based on current time and username
--- @param name string Username
M.get_greeting = function(name)
  local tableTime = os.date("*t")
  local hour = tableTime.hour
  local greetingsTable = {
    [1] = "󰙃  Why are you still up, " .. name .. "?",
    [2] = "  Good morning, " .. name,
    [3] = "  Good afternoon, " .. name,
    [4] = "  Good evening, " .. name,
  }
  local greetingIndex = 0
  if hour >= 23 or hour < 7 then
    greetingIndex = 1
  elseif hour < 12 then
    greetingIndex = 2
  elseif hour >= 12 and hour < 18 then
    greetingIndex = 3
  elseif hour >= 18 and hour < 23 then
    greetingIndex = 4
  end
  return greetingsTable[greetingIndex]
end

return M
