return {
	cmd = { "rust-analyzer" },
	root_markers = { "Cargo.lock" },
	filetypes = { "rust" },
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
			},
			check = {
				command = "clippy",
			},
			diagnostics = {
				enable = true,
			},
		},
	},
}
