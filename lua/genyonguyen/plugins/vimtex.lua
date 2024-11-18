return {
  "lervag/vimtex",
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "general"
    vim.g.vimtex_view_general_viewer = "okular"
    vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
    vim.g.vimtex_compiler_latexmk = {
      engine = '-pdf',
      options = { '-verbose', '-file-line-error', '-interaction=nonstopmode', '-synctex=1', '-aux-directory=build' },
      build_dir = './build',
      hook_post_compile = function()
        local tex_file = vim.fn.expand('%:t:r')  -- Gets the current file name without extension
        os.execute('mv ' .. tex_file .. '.fls ' .. tex_file .. '.fls')
      end,
    }
  end
}
