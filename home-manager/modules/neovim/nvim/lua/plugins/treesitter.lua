require("nvim-treesitter.configs").setup({
	ensure_installed = { "vim", "vimdoc", "lua", "cpp", "zig" },
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
	refactor = {
		highlight_definitions = {
			enable = true,
			clear_on_cursor_move = false,
		},
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "grr",
			},
		},
	},
})
