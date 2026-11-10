return {

  -- Improve viewing Markdown files.
  {
    -- The old repo name (MeanderingProgrammer/markdown.nvim) installed a second
    -- copy next to render-markdown.nvim; one spec is enough.
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "opencode_output" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      render_modes = { "n", "c" },
      file_types = { "markdown", "opencode_output" },
      headings = { " ", "󰉬  ", "󰉭  ", "󰉮  ", "󰉯  ", "󰉰  " },
      highlights = {
        heading = {
          -- Background of heading line
          backgrounds = { "TabLineFill" },
          -- Foreground of heading character only
          foregrounds = {
            "markdownH1",
            "markdownH2",
            "markdownH3",
            "markdownH4",
            "markdownH5",
            "markdownH6",
          },
        },
        -- Horizontal break
        dash = "LineNr",
        -- Code blocks
        code = "ColorColumn",
        -- Bullet points in list
        bullet = "@include",
        checkbox = {
          -- Unchecked checkboxes
          unchecked = "@markup.list.unchecked",
          -- Checked checkboxes
          checked = "@markup.heading",
        },
        table = {
          -- Header of a markdown table
          head = "@markup.heading",
          -- Non header row of a markdown table
          row = "Normal",
        },
        -- LaTeX blocks
        latex = "@markup.math",
        -- Quote character in block quote
        quote = "@markup.quote",
      },
    },
  },
}
