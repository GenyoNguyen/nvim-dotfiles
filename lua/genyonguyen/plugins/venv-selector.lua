return {
    'linux-cultist/venv-selector.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python', 'sharkdp/fd'},
    opts = {
        -- Your options go here
        name = {'venv', '.venv'},
        -- auto_refresh = false
        path = '/home/genyonguyen/'
    },
    lazy = true,
    branch = "regexp",
    keys = {
        -- Keymap to open VenvSelector to pick a venv.
        { '<leader>vs', '<cmd>VenvSelect<cr>' },
        -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
        { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
    },
    config = function()
        require("venv-selector").setup()
    end,
}
