return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			-- list of servers for mason to install
			ensure_installed = {
				"lua_ls", -- Lua LSP
				"rust_analyzer", -- Rust LSP
				-- "ruff", -- Python LSP
			},
		},
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			"neovim/nvim-lspconfig",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				-- Formatters (for conform.nvim and general use)
				"stylua",
				"prettierd",
				"black",
				"isort",
				"latexindent",
				"bibtex-tidy",

				-- Linters and diagnostics
				"luacheck", -- Lua linting

				-- Additional useful tools
				"shfmt", -- Shell formatter
				"shellcheck", -- Shell linter

				-- Optional but useful additions
				"markdownlint", -- Markdown linting
				"yamllint", -- YAML linting
				"jsonlint", -- JSON linting
			},
		},
		dependencies = {
			"williamboman/mason.nvim",
		},
	},
}
