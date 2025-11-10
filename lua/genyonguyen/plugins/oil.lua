return {
	"stevearc/oil.nvim",
	-- enabled = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- Declare a global function to retrieve the current directory
		function _G.get_oil_winbar()
			local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
			local dir = require("oil").get_current_dir(bufnr)
			if dir then
				return vim.fn.fnamemodify(dir, ":~")
			else
				-- If there is no current directory (e.g. over ssh), just show the buffer name
				return vim.api.nvim_buf_get_name(0)
			end
		end

		local detail = false

		require("oil").setup({
			default_file_explorer = true, -- start up nvim with oil instead of netrw
			columns = { "icon" },
			keymaps = {
				["<C-h>"] = false,
				["<C-c>"] = false, -- prevent from closing Oil as <C-c> is esc key
				["<M-h>"] = "actions.select_split",
				["q"] = "actions.close",
				["lf"] = {
					desc = "Toggle file detail view",
					callback = function()
						detail = not detail
						if detail then
							require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
						else
							require("oil").set_columns({ "icon" })
						end
					end,
				},
			},
			delete_to_trash = true,
			view_options = {
				show_hidden = true,
			},
			skip_confirm_for_simple_edits = true,
			win_options = {
				winbar = "%!v:lua.get_oil_winbar()",
			},
		})

		-- opens parent dir over current active window
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		-- open parent dir in float window
		vim.keymap.set("n", "<leader>-", require("oil").toggle_float)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "oil", -- Adjust if Oil uses a specific file type identifier
			callback = function()
				vim.opt_local.cursorline = true
			end,
		})
	end,
}
