local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
  "n",
  "<leader>a",
  function()
    vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set(
  "n",
  "<leader>d",
  function()
    vim.cmd.RustLsp('openDocs') -- supports rust-analyzer's grouping
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set(
  "n",
  "<leader>c",
  function()
    vim.cmd.RustLsp('openCargo') -- supports rust-analyzer's grouping
  end,
  { silent = true, buffer = bufnr }
)
