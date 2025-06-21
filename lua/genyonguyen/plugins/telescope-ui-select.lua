return {
  'nvim-telescope/telescope-ui-select.nvim',
  opt = true,
  as = 'telescope-ui-select',
  config = function()
    require('telescope').setup {
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            -- even more opts
          }
        }
      },
    }
  end,
}
