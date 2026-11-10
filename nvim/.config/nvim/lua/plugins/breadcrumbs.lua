-- Breadcrumbs / winbar (replaces barbecue.nvim, which has been archived;
-- dropbar is the maintained replacement and needs zero configuration)
return {
  "Bekaboo/dropbar.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>[",
      function()
        require("dropbar.api").pick()
      end,
      mode = "n",
      desc = "Pick symbol in winbar",
    },
  },
}
