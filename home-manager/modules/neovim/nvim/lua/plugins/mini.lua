return {
	{
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			require("mini.basics").setup({
				options = {
					extra_ui = false,
				},
			})
		end,
	},
}
