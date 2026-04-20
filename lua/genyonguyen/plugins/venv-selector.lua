return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } }, -- optional: you can also use fzf-lua, snacks, mini-pick instead.
	},
	ft = "python", -- Load when opening Python files
	keys = {
		{
			",d",
			function()
				require("venv-selector").deactivate()
				require("venv-selector").activate_from_path("/opt/miniconda3/bin/python")
			end,
			desc = "Deactivate virtual environment",
		},
		{ ",v", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
	},
	opts = { -- this can be an empty lua table - just showing below for clarity.
		search = {
			conda = {
				command = "fd /python$ ~/Data/.conda/envs/*/bin/ --full-path --color never -E /proc",
				type = "anaconda",
			},
		}, -- if you add your own searches, they go here.
		options = {
			activate_venv_in_terminal = false,
			statusline_func = {
				lualine = function()
					local venv_path = require("venv-selector").venv()
					if not venv_path or venv_path == "" then
						return ""
					end

					local venv_name = vim.fn.fnamemodify(venv_path, ":t")
					if not venv_name or venv_name == "miniconda3" then
						return ""
					end

					local output = "  " .. venv_name .. " " -- Changes only the icon but you can change colors or use powerline symbols here.
					return output
				end,
			},
		}, -- if you add plugin options, they go here.
	},
}
