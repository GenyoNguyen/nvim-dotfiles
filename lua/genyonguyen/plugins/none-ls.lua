return {
  "nvimtools/none-ls.nvim",
  event = "VeryLazy",
  opts = function ()
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    local null_ls = require("null-ls")
    local opts = {
      sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.google_java_format,
      },
      on_attach = function (client, bufnr)
        if client.supports_method("textDocument/formatting") or client.name == "jdtls" then
          vim.api.nvim_clear_autocmds({
            group = augroup,
            buffer = bufnr,
          })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function ()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end
    }

    return opts
  end
}
