return {
  "navarasu/onedark.nvim",
  name = "onedark",
  priority = 1000,
  config = function()
    require("onedark").setup({
      style = "warm",
      transparent = true,
      ending_tildes = true,
      highlights = {
        ['@comment'] = { fg = '#FF8800' } -- Example: Bright orange color
      }
    })
    require("onedark").load()
  end,
}
-- This is a comment
