return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
		},
		config = function()
			require("neo-tree").setup({
				default_component_configs = {
					diagnostics = {
						symbols = {
							hint = "󰌵",
							info = "",
							warn = "",
							error = "",
						},
						highlights = {
							hint = "DiagnosticSignHint",
							info = "DiagnosticSignInfo",
							warn = "DiagnosticSignWarn",
							error = "DiagnosticSignError",
						},
					},
				},
				window = {
					mappings = {
						["E"] = "open_drop",
					},
				},
			})
		end,
	},
}
