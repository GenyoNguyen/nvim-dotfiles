return {
	"github/copilot.vim",
	config = function()
		vim.g.copilot_filetypes = {
			["*"] = true,
			org = false,
		}
	end,
}
