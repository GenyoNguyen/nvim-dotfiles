return {
	{
		"nvim-orgmode/orgmode",
		event = "VeryLazy",
		ft = { "org" },
		config = function()
			-- Setup orgmode
			local org = require("orgmode")

			-- org.setup_ts_grammar()
			org.setup({
				org_agenda_files = "~/Data/orgfiles/**/*",
				org_default_notes_file = "~/Data/orgfiles/notes.org",
				org_startup_indented = true,
				org_capture_templates = {
					p = {
						description = "Project",
						template = "* PROJ %^{Project name}\n:PROPERTIES:\n:CREATED: %U\n:END:\n** TODO %?",
						target = "~/Data/orgfiles/projects.org",
					},
					n = {
						description = "Notes",
						template = "- %?",
					},
				},
				mappings = {
					org = {
						org_toggle_checkbox = "<leader>cx",
					},
				},
				org_highlight_latex_and_related = "entities",
				org_custom_exports = {
					x = {
						label = "Export to PDF using xelatex",
						action = function(exporter)
							local current_file = vim.api.nvim_buf_get_name(0)
							local target = vim.fn.fnamemodify(current_file, ":p:r") .. ".pdf"
							local command = { "pandoc", current_file, "-o", target, "--pdf-engine=xelatex" }
							local on_success = function(output)
								print("Success!")
								vim.api.nvim_echo({ { table.concat(output, "\n") } }, true, {})
							end
							local on_error = function(err)
								print("Error!")
								vim.api.nvim_echo({ { table.concat(err, "\n"), "ErrorMsg" } }, true, {})
							end
							return exporter(command, target, on_success, on_error)
						end,
					},
				},
			})

			-- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
			-- add ~org~ to ignore_install
			-- require('nvim-treesitter.configs').setup({
			--   ensure_installed = 'all',
			--   ignore_install = { 'org' },
			-- })
		end,
	},
	{
		"chipsenkbeil/org-roam.nvim",
		dependencies = "nvim-orgmode/orgmode",
		config = function()
			require("org-roam").setup({
				directory = "~/Data/orgfiles/roam",
				templates = {
					r = {
						description = "research",
						template = "%?",
						target = "research/%[slug].org",
					},
				},
				extensions = {
					dailies = {
						templates = {
							d = {
								description = "default",
								template = require("genyonguyen.plugins.snippets.orgmode.daily"),
								target = "%<%Y-%m-%d>.org",
							},
							c = {
								description = "capture",
								template = "%?",
								target = "%<%Y-%m-%d>.org",
							},
						},
					},
				},
			})
		end,
	},
	{
		"akinsho/org-bullets.nvim",
		config = function()
			require("org-bullets").setup({
				concealcursor = true,
				symbols = {
					list = "-",
					checkboxes = {
						done = { "", "@org.keyword.done" },
						todo = { " ", "@org.keyword.todo" },
					},
				},
			})
		end,
	},
}
