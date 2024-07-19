return {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	config = function()
		require("oil").setup({
			skip_confirm_for_simple_edits = true,
			columns = {
				"icon",
				"permissions",
				"size",
			},
		})
	end,
}
