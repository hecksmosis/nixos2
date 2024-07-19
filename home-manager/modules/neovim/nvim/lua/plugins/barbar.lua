return {
	"romgrk/barbar.nvim",
	config = function()
		require("barbar").setup({
			sidebar_filetypes = {
				["neo-tree"] = true,
			},
		})
	end,
}
