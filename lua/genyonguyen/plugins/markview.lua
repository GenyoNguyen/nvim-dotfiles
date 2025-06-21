return {
    "OXY2DEV/markview.nvim",
    enabled = true,
    lazy = false,
    ft = { "markdown", "norg", "rmd", "org", "vimwiki", "Avante" },
    opts = {
      preview = {
        filetypes = { "markdown", "norg", "rmd", "org", "vimwiki", "Avante" },
        buf_ignore = {},
        icon_provider = "devicons",
      },
      max_length = 99999,
    },
}
