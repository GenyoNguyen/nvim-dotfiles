return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = {
					"json",
					"javascript",
					"typescript",
					"tsx",
					"go",
					"yaml",
					"html",
					"css",
					"python",
					"http",
					"prisma",
					"markdown",
					"markdown_inline",
					"svelte",
					"graphql",
					"bash",
					"lua",
					"vim",
					"vimdoc",
					"dockerfile",
					"gitignore",
					"query",
					"vimdoc",
					"c",
					"cpp",
					"java",
					"rust",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
					},
				},
				additional_vim_regex_highlighting = false,
				highlight = {
					enable = true,
				},

				indent = {
					enable = true,
				},
			})
		end,
	},
	-- NOTE: js,ts,jsx,tsx Auto Close Tags
	{
		"windwp/nvim-ts-autotag",
		enabled = true,
		ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
		config = function()
			-- Independent nvim-ts-autotag setup
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- Auto-close tags
					enable_rename = true, -- Auto-rename pairs
					enable_close_on_slash = false, -- Disable auto-close on trailing `</`
				},
				per_filetype = {
					["html"] = {
						enable_close = true, -- Disable auto-closing for HTML
					},
					["typescriptreact"] = {
						enable_close = true, -- Explicitly enable auto-closing (optional, defaults to `true`)
					},
				},
			})
		end,
	},
}
