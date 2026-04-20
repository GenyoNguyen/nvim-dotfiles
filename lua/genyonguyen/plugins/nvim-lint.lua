return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		-- Configure custom linters using Mason-managed tools
		local mason_bin_dir = vim.fn.stdpath("data") .. "/mason/bin"

		-- Configure ESLint D
		lint.linters.eslint_d.args = {
			"--no-warn-ignored",
			"--format",
			"json",
			"--stdin",
			"--stdin-filename",
			function()
				return vim.fn.expand("%:p")
			end,
		}

		-- Configure biber
		lint.linters.biber = {
			cmd = "biber",
			args = function()
				-- biber needs a .bcf file, but for linting .bib directly:
				return { "--tool", vim.fn.expand("%:p") }
			end,
			stdin = false,
			stream = "stdout",
			ignore_exitcode = true,
			parser = function(output, bufnr)
				local diagnostics = {}
				for line in output:gmatch("[^\r\n]+") do
					local filename, lnum, col, msg = line:match("([^:]+):(%d+):(%d+):%s*(.*)")
					if filename then
						table.insert(diagnostics, {
							lnum = tonumber(lnum) - 1,
							col = tonumber(col) - 1,
							message = msg,
							severity = vim.diagnostic.severity.WARN,
							source = "biber",
						})
					end
				end
				return diagnostics
			end,
		}

		-- Configure chktex
		lint.linters.chktex = vim.tbl_extend("force", lint.linters.chktex, {
			ignore_exitcode = true,
		})

		-- Configure luacheck

		-- Configure linters by filetype (using Mason-managed tools)
		lint.linters_by_ft = {
			-- Go
			go = { "golangcilint" },

			-- JavaScript/TypeScript
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },

			-- Lua
			-- lua = { "luacheck" },

			-- Shell
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			zsh = { "shellcheck" },

			-- You can add more linters here as needed
			-- python = { "pyrefly" },
			-- rust = { "clippy" },

			tex = { "chktex" },
			bib = { "biber" },
		}

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				-- Only lint if linters are available for this filetype
				local linters = lint.linters_by_ft[vim.bo.filetype]
				if linters and #linters > 0 then
					lint.try_lint()
				end
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })

		-- Show linter status
		vim.keymap.set("n", "<leader>li", function()
			local linters = lint.linters_by_ft[vim.bo.filetype] or {}
			if #linters == 0 then
				print("No linters configured for filetype: " .. vim.bo.filetype)
			else
				print("Linters for " .. vim.bo.filetype .. ": " .. table.concat(linters, ", "))

				-- Show which tools are being used
				if vim.bo.filetype == "php" then
					if string.find(pint_cmd, "mason") then
						print("Using Mason pint: " .. pint_cmd)
					else
						print("Using system pint: " .. pint_cmd)
					end
				end
			end
		end, { desc = "Show available linters for current filetype" })
	end,
}
