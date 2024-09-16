return {
  "navarasu/onedark.nvim",
  name = "onedark",
  priority = 1000,
  config = function()
    require("onedark").setup({
      style = "darker",
      transparent = true,
      ending_tildes = true,
    })
    require("onedark").load()
  end,
}
