return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters = {
				["markdown-toc"] = {
					condition = function(_, ctx)
						for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
							if line:find("<!%-%- toc %-%->") then
								return true
							end
						end
						return false
					end,
				},
				["markdownlint-cli2"] = {
					condition = function(_, ctx)
						local diag = vim.tbl_filter(function(d)
							return d.source == "markdownlint"
						end, vim.diagnostic.get(ctx.buf))
						return #diag > 0
					end,
				},
			},
			formatters_by_ft = {
				json = { "prettierd" },
				yaml = { "prettierd" },
				lua = { "stylua" },
				python = { "black", "isort", "autoflake" },
				markdown = { "prettierd", "markdown-toc" },
				-- ["markdown.mdx"] = { "prettierd", "markdownlint", "markdown-toc" },
				tex = { "latexindent" },
				bib = { "bibtex-tidy" },
				rust = { "rustfmt" },
			},
		})

		-- Configure individual formatters
		conform.formatters.prettierd = {
			args = {
				"--stdin-filepath",
				"$FILENAME",
				"--tab-width",
				"4",
				"--use-tabs",
				"false",
			},
		}
		conform.formatters.shfmt = {
			prepend_args = { "-i", "4" },
		}

		local format_on_save_filetypes = {
			"lua",
			"tex",
			"bib",
			"rust",
		}

		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				local filetype = vim.bo.filetype
				if not vim.tbl_contains(format_on_save_filetypes, filetype) then
					return
				end
				for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
					if client.server_capabilities.documentFormattingProvider then
						vim.lsp.buf.format()
						return
					end
				end
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format whole file or range (in visual mode) with" })
	end,
}
