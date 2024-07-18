local on_attach = function(_, bufnr)
	local bufmap = function(keys, func)
		vim.keymap.set("n", keys, func, { silent = true, buffer = bufnr })
	end
	local vbufmap = function(keys, func)
		vim.keymap.set("v", keys, func, { silent = true, buffer = bufnr })
	end

	local join_lines = function()
		vim.cmd.RustLsp("joinLines")
	end

	bufmap("J", join_lines)
	vbufmap("J", join_lines)
	bufmap("<leader>r", vim.lsp.buf.rename)
	bufmap("gd", vim.lsp.buf.definition)
	bufmap("gD", vim.lsp.buf.declaration)
	bufmap("gI", vim.lsp.buf.implementation)
	bufmap("<leader>D", vim.lsp.buf.type_definition)

	bufmap("gr", require("telescope.builtin").lsp_references)
	bufmap("<leader>s", require("telescope.builtin").lsp_document_symbols)
	bufmap("<leader>S", require("telescope.builtin").lsp_dynamic_workspace_symbols)

	bufmap("<leader>mk", function()
		vim.cmd.RustLsp({ "moveItem", "up" })
	end)
	bufmap("<leader>mj", function()
		vim.cmd.RustLsp({ "moveItem", "down" })
	end)

	bufmap("<leader>ex", function()
		vim.cmd.RustLsp("explainError")
	end)
	bufmap("<leader>lf", function()
		vim.cmd.RustLsp("renderDiagnostic")
	end)
	bufmap("<leader>ca", function()
		vim.cmd.RustLsp("codeAction")
	end)
	bufmap("<leader>od", function()
		vim.cmd.RustLsp("openDocs")
	end)
	bufmap("<leader>ct", function()
		vim.cmd.RustLsp("openCargo")
	end)

	bufmap("K", vim.lsp.buf.hover)

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

vim.g.rustaceanvim = {
	server = {
		on_attach = on_attach,
		capabilities = capabilities,
		default_settings = {
			["rust-analyzer"] = {
				files = {
					excludeDirs = { "./target" },
				},
			},
		},
	},
	tools = {
		enable_clippy = true,
	},
}
