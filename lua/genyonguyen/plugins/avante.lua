return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	--@module 'avante'
	opts = {
		-- add any opts here
		-- for example
		provider = "copilot", -- default provider
		providers = {
			vertex = {
				hide_in_model_selector = true,
			},
			vertex_claude = {
				hide_in_model_selector = true,
			},
			cohere = {
				hide_in_model_selector = true,
			},
			bedrock = {
				hide_in_model_selector = true,
			},
			-- other providers
			["claude-opus"] = {
				hide_in_model_selector = true,
			},
			["claude-haiku"] = {
				hide_in_model_selector = true,
			},
			["openai-gpt-4o-mini"] = {
				hide_in_model_selector = true,
			},
		},
		behaviour = {
			auto_approve_tool_permissions = false, -- <-- this one
			-- auto_apply_diff_after_generation = false,
		},
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"echasnovski/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		-- {
		-- 	-- Make sure to set this up properly if you have lazy=true
		-- 	"MeanderingProgrammer/render-markdown.nvim",
		-- 	opts = {
		-- 		file_types = { "markdown", "Avante" },
		-- 	},
		-- 	ft = { "markdown", "Avante" },
		-- },
	},
}
