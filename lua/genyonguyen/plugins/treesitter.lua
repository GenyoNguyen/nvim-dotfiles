return {
	{
		"nvim-treesitter/nvim-treesitter",
		commit = "90cd6580e720caedacb91fdd587b747a6e77d61f",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
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
				textobjects = {
					move = {
						enable = true,
						set_jumps = false, -- you can change this if you want.
						goto_next_start = {},
						goto_previous_start = {},
					},
					select = {
						enable = true,
						lookahead = true, -- you can change this if you want
						keymaps = {
							--- ... other keymaps
							["ib"] = { query = "@code_cell.inner", desc = "in block" },
							["ab"] = { query = "@code_cell.outer", desc = "around block" },
						},
					},
					swap = { -- Swap only works with code blocks that are under the same
						-- markdown header
						enable = true,
						swap_next = {
							--- ... other keymap
							["<leader>sbl"] = "@code_cell.outer",
						},
						swap_previous = {
							--- ... other keymap
							["<leader>sbh"] = "@code_cell.outer",
						},
					},
				},
			})

			vim.keymap.set("n", "]b", function()
				require("nvim-treesitter.textobjects.move").goto_next_start("@code_cell.inner")
				vim.cmd("normal! zz")
			end, { silent = true, desc = "Next code cell" })

			vim.keymap.set("n", "[b", function()
				require("nvim-treesitter.textobjects.move").goto_previous_start("@code_cell.inner")
				vim.cmd("normal! zz")
			end, { silent = true, desc = "Previous code cell" })
		end,
	},
	-- NOTE: Show code context at the top
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true,
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
